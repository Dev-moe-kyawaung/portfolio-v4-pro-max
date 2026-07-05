import fs from "fs";
import path from "path";

const logDir = "logs";
const logFile = path.join(logDir, "tailwind-check.log");

fs.mkdirSync(logDir, { recursive: true });

let errors = 0;
const lines = [];

function stamp() {
  return new Date().toISOString();
}

function logLine(message) {
  const line = `[${stamp()}] ${message}`;
  lines.push(line);
  console.log(message);
}

function logError(message) {
  const line = `[${stamp()}] ERROR: ${message}`;
  lines.push(line);
  console.log(`BAD: ${message}`);
  errors++;
}

function exists(file) {
  return fs.existsSync(file);
}

function read(file) {
  return fs.readFileSync(file, "utf8");
}

function checkFile(file) {
  if (!exists(file)) logError(`Missing file: ${file}`);
  else logLine(`OK: Found file: ${file}`);
}

function checkMatch(file, regex, label) {
  if (!exists(file)) {
    logError(`${label} (${file} missing)`);
    return;
  }
  if (regex.test(read(file))) logLine(`OK: ${label}`);
  else logError(label);
}

logLine("Checking Tailwind v3 setup...");

["package.json", "tailwind.config.js", "postcss.config.js", "src/index.css", "src/main.jsx"].forEach(checkFile);

checkMatch("package.json", /"tailwindcss"s*:s*"^?3|"tailwindcss"s*:s*"3/, "Tailwind v3 dependency");
checkMatch("package.json", /"type"s*:s*"module"/, "ES module package type");
checkMatch("tailwind.config.js", /content:s*["./index.html",s*"./src/**/*.{js,ts,jsx,tsx}"]/, "Tailwind content paths");
checkMatch("tailwind.config.js", /plugins:s*[]/, "Tailwind plugins array");
checkMatch("postcss.config.js", /tailwindcss:s*{}/, "PostCSS tailwindcss plugin");
checkMatch("postcss.config.js", /autoprefixer:s*{}/, "PostCSS autoprefixer plugin");
checkMatch("src/index.css", /@tailwind base;/, "Tailwind base directive");
checkMatch("src/index.css", /@tailwind components;/, "Tailwind components directive");
checkMatch("src/index.css", /@tailwind utilities;/, "Tailwind utilities directive");
checkMatch("src/main.jsx", /imports+"./index.css";/, "Main CSS import");

if (exists("postcss.config.js") && /@tailwindcss/postcss/.test(read("postcss.config.js"))) {
  logError("v4-only @tailwindcss/postcss found in v3 config");
}

if (exists("src/index.css") && /@imports+["']tailwindcss["']/.test(read("src/index.css"))) {
  logError("v4-style Tailwind CSS import found in v3 CSS entry");
}

const header = `
===== ${stamp()} =====
`;
fs.appendFileSync(logFile, header + lines.join("
") + "
", "utf8");

console.log();
if (errors === 0) {
  console.log(`PASS: Tailwind v3 setup looks consistent. Log appended to ${logFile}`);
  process.exit(0);
} else {
  console.log(`FAIL: Found ${errors} issue(s). Log appended to ${logFile}`);
  process.exit(1);
}
