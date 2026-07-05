#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="${1:-.}"
LOG_DIR="$ROOT_DIR/logs"
LOG_FILE="$LOG_DIR/tailwind-check.log"

mkdir -p "$LOG_DIR"
touch "$LOG_FILE"

log() {
  local msg="$1"
  local line="[$(date -Iseconds)] $msg"
  echo "$line" | tee -a "$LOG_FILE"
}

backup_file() {
  local f="$1"
  if [ -f "$ROOT_DIR/$f" ]; then
    cp "$ROOT_DIR/$f" "$ROOT_DIR/$f.bak.$(date +%Y%m%d_%H%M%S)"
    log "Backed up $f"
  else
    log "Skipped backup for missing file: $f"
  fi
}

log "Starting Tailwind v3 auto-fix in: $ROOT_DIR"

cd "$ROOT_DIR"

for f in package.json tailwind.config.js postcss.config.js src/index.css src/main.jsx; do
  backup_file "$f"
done

if [ -f package.json ] && command -v node >/dev/null 2>&1; then
  log "Updating package.json dependencies and scripts"
  node <<'NODE'
const fs = require("fs");
const p = "package.json";
const data = JSON.parse(fs.readFileSync(p, "utf8"));
data.type = "module";
data.scripts ||= {};
Object.assign(data.scripts, {
  dev: "vite",
  build: "vite build",
  preview: "vite preview"
});
data.dependencies ||= {};
Object.assign(data.dependencies, {
  react: "^18.3.1",
  "react-dom": "^18.3.1",
  "framer-motion": "^11.11.9"
});
data.devDependencies ||= {};
Object.assign(data.devDependencies, {
  "@vitejs/plugin-react": "^4.3.1",
  autoprefixer: "^10.4.20",
  postcss: "^8.4.49",
  tailwindcss: "^3.4.17",
  vite: "^5.4.10"
});
fs.writeFileSync(p, JSON.stringify(data, null, 2) + "
");
NODE
  log "package.json updated"
else
  log "WARNING: package.json not updated (node missing or file missing)"
fi

cat > tailwind.config.js <<'EOF'
/** @type {import('tailwindcss').Config} */
export default {
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}"],
  theme: {
    extend: {
      colors: {
        brand: {
          50: "#f5f7ff",
          100: "#ebefff",
          200: "#cfd9ff",
          300: "#aab8ff",
          400: "#7f90ff",
          500: "#5b6dff",
          600: "#4652ff",
          700: "#3740e6",
          800: "#2f36b8",
          900: "#282f94"
        }
      },
      boxShadow: {
        glow: "0 0 40px rgba(91, 109, 255, 0.35)"
      }
    }
  },
  plugins: []
};
EOF
log "Rewrote tailwind.config.js"

cat > postcss.config.js <<'EOF'
export default {
  plugins: {
    tailwindcss: {},
    autoprefixer: {}
  }
};
EOF
log "Rewrote postcss.config.js"

cat > src/index.css <<'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;

html {
  scroll-behavior: smooth;
}

body {
  @apply bg-slate-950 text-slate-100 antialiased;
}

::selection {
  @apply bg-brand-500 text-white;
}
EOF
log "Rewrote src/index.css"

if [ -f src/main.jsx ]; then
  if grep -q 'import "./index.css";' src/main.jsx; then
    log "src/main.jsx already imports index.css"
  else
    log "Updating src/main.jsx to import index.css"
    if grep -q 'import App from "./App";' src/main.jsx; then
      perl -0pi -e 's#import App from "./App";#import App from "./App";
import "./index.css";#' src/main.jsx
    else
      cat > src/main.jsx <<'EOF'
import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App";
import "./index.css";

ReactDOM.createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
EOF
    fi
    log "src/main.jsx updated"
  fi
else
  log "WARNING: src/main.jsx not found"
fi

log "Tailwind v3 auto-fix complete"
echo "Done. Logs written to $LOG_FILE"
