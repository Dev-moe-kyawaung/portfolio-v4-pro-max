#!/usr/bin/env bash
set -e

PROJECT_NAME="${1:-v4-pro-max-quantum-ai-portfolio}"

mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME"

mkdir -p public
mkdir -p src
mkdir -p src/data
mkdir -p src/hooks
mkdir -p src/styles
mkdir -p src/pages
mkdir -p src/assets/images
mkdir -p src/assets/icons
mkdir -p src/assets/video
mkdir -p src/assets/fonts
mkdir -p src/components/Layout
mkdir -p src/components/Navbar
mkdir -p src/components/Footer
mkdir -p src/components/Hero
mkdir -p src/components/Stats
mkdir -p src/components/About
mkdir -p src/components/Services
mkdir -p src/components/Projects
mkdir -p src/components/CaseStudies
mkdir -p src/components/Gallery
mkdir -p src/components/Testimonials
mkdir -p src/components/Pricing
mkdir -p src/components/FAQ
mkdir -p src/components/Contact
mkdir -p src/components/Social
mkdir -p src/components/BackToTop
mkdir -p src/components/Cursor
mkdir -p src/components/Preloader
mkdir -p src/components/Modal
mkdir -p src/components/Carousel
mkdir -p src/components/Forms
mkdir -p src/components/Transitions
mkdir -p src/components/NextGen
mkdir -p src/components/NextGen/AIAgent
mkdir -p src/components/NextGen/VoiceNav
mkdir -p src/components/NextGen/DynamicPersona
mkdir -p src/components/NextGen/QuantumGrid
mkdir -p src/components/NextGen/EthicalAI
mkdir -p src/components/NextGen/AR3DViewer
mkdir -p src/components/NextGen/AdaptiveTheme
mkdir -p src/components/NextGen/EmotionHeatmap
mkdir -p src/components/NextGen/SpatialUI
mkdir -p src/components/NextGen/PredictiveNav

cat <<'EOF' > public/favicon.ico
EOF

cat <<'EOF' > src/index.css
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

cat <<'EOF' > src/main.jsx
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

cat <<'EOF' > src/App.jsx
import Layout from "./components/Layout/Layout";

export default function App() {
  return <Layout />;
}
EOF

cat <<'EOF' > src/data/siteContent.js
export const navLinks = [
  { label: "Home", href: "#home" },
  { label: "Projects", href: "#projects" },
  { label: "Case Studies", href: "#case-studies" },
  { label: "About", href: "#about" },
  { label: "Contact", href: "#contact" },
];

export const heroContent = {
  badge: "V4 PRO MAX · Quantum AI Portfolio 2026–2027",
  title: "Next-Gen Quantum AI Experiences — Human-Centered, Adaptive, and Ethical.",
  subtitle:
    "A 2026–2027 portfolio architecture blending AI-driven personalization, organic layouts, accessibility-first design, and performance-led creativity.",
  primaryCta: { label: "View Projects", href: "#projects" },
  secondaryCta: { label: "Contact", href: "#contact" },
};

export const services = [
  { title: "AI-Driven UX", desc: "Adaptive interfaces that learn from behavior and context." },
  { title: "Organic Layouts", desc: "Anti-grid, fluid structures that feel more human." },
  { title: "Ethical AI", desc: "Transparent data controls and explainable AI by design." },
];

export const projects = [
  {
    title: "Quantum AI Dashboard",
    category: "AI / Data",
    description: "A real-time, adaptive dashboard visualizing complex AI insights.",
    tech: ["React", "Tailwind", "D3", "AI"],
    link: "#",
  },
  {
    title: "Voice-First Portfolio",
    category: "Accessibility",
    description: "A voice-optimized layout with natural language navigation.",
    tech: ["Web Speech", "React", "Accessibility"],
    link: "#",
  },
  {
    title: "Spatial 3D Case Study",
    category: "3D / AR",
    description: "WebXR-driven 3D walkthroughs and interactive AR demos.",
    tech: ["WebXR", "Three.js", "React"],
    link: "#",
  },
];

export const testimonials = [
  {
    name: "Sofia Chen",
    role: "Product Lead",
    quote: "The adaptive UX made the site feel alive. It’s the most advanced portfolio I’ve seen.",
  },
  {
    name: "Marcus Okonkwo",
    role: "CTO",
    quote: "Ethical AI features and transparency controls built trust instantly.",
  },
];
EOF

cat <<'EOF' > src/components/Layout/Layout.jsx
import Navbar from "../Navbar/Navbar";
import Hero from "../Hero/Hero";
import Stats from "../Stats/Stats";
import Services from "../Services/Services";
import Projects from "../Projects/Projects";
import About from "../About/About";
import CaseStudies from "../CaseStudies/CaseStudies";
import Testimonials from "../Testimonials/Testimonials";
import Contact from "../Contact/Contact";
import Footer from "../Footer/Footer";
import AIAgent from "../NextGen/AIAgent/AIAgent";
import VoiceNav from "../NextGen/VoiceNav/VoiceNav";
import EthicalAI from "../NextGen/EthicalAI/EthicalAI";

export default function Layout() {
  return (
    <div className="min-h-screen bg-slate-950 text-white">
      <VoiceNav />
      <Navbar />
      <main>
        <section id="home">
          <Hero />
        </section>
        <Stats />
        <Services />
        <Projects />
        <About />
        <CaseStudies />
        <Testimonials />
        <Contact />
      </main>
      <Footer />
      <AIAgent />
      <EthicalAI />
    </div>
  );
}
EOF

cat <<'EOF' > src/components/Navbar/Navbar.jsx
import { useState } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { navLinks } from "../../data/siteContent";

export default function Navbar() {
  const [open, setOpen] = useState(false);

  return (
    <header className="sticky top-0 z-50 border-b border-white/10 bg-slate-950/85 backdrop-blur">
      <div className="mx-auto flex max-w-7xl items-center justify-between px-6 py-4">
        <a href="#home" className="text-lg font-semibold tracking-wide text-white">
          V4 PRO MAX
        </a>

        <nav className="hidden gap-8 md:flex">
          {navLinks.map((item) => (
            <a
              key={item.label}
              href={item.href}
              className="text-sm text-slate-300 transition hover:text-white"
            >
              {item.label}
            </a>
          ))}
        </nav>

        <button
          onClick={() => setOpen((v) => !v)}
          className="rounded-full border border-white/15 px-4 py-2 text-sm text-white md:hidden"
        >
          Menu
        </button>
      </div>

      <AnimatePresence>
        {open && (
          <motion.nav
            initial={{ opacity: 0, y: -8 }}
            animate={{ opacity: 1, y: 0 }}
            exit={{ opacity: 0, y: -8 }}
            className="border-t border-white/10 bg-slate-950 px-6 py-4 md:hidden"
          >
            <div className="flex flex-col gap-4">
              {navLinks.map((item) => (
                <a
                  key={item.label}
                  href={item.href}
                  onClick={() => setOpen(false)}
                  className="text-slate-300 transition hover:text-white"
                >
                  {item.label}
                </a>
              ))}
            </div>
          </motion.nav>
        )}
      </AnimatePresence>
    </header>
  );
}
EOF

cat <<'EOF' > src/components/Hero/Hero.jsx
import { motion } from "framer-motion";
import { heroContent } from "../../data/siteContent";

export default function Hero() {
  return (
    <section className="mx-auto grid min-h-[calc(100vh-80px)] max-w-7xl items-center gap-12 px-6 py-20 lg:grid-cols-2">
      <motion.div
        initial={{ opacity: 0, y: 28 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.7 }}
        className="space-y-6"
      >
        <span className="inline-flex rounded-full border border-white/10 bg-white/5 px-4 py-1 text-sm text-slate-300">
          {heroContent.badge}
        </span>

        <h1 className="max-w-2xl text-4xl font-bold tracking-tight sm:text-5xl lg:text-7xl">
          {heroContent.title}
        </h1>

        <p className="max-w-xl text-base leading-7 text-slate-300 sm:text-lg">
          {heroContent.subtitle}
        </p>

        <div className="flex flex-wrap gap-4">
          <motion.a
            href={heroContent.primaryCta.href}
            whileHover={{ scale: 1.04 }}
            whileTap={{ scale: 0.98 }}
            className="rounded-full bg-white px-6 py-3 font-medium text-slate-950 transition hover:bg-slate-200"
          >
            {heroContent.primaryCta.label}
          </motion.a>

          <motion.a
            href={heroContent.secondaryCta.href}
            whileHover={{ scale: 1.04 }}
            whileTap={{ scale: 0.98 }}
            className="rounded-full border border-white/15 bg-white/5 px-6 py-3 font-medium text-white transition hover:bg-white/10"
          >
            {heroContent.secondaryCta.label}
          </motion.a>
        </div>
      </motion.div>

      <motion.div
        initial={{ opacity: 0, scale: 0.92 }}
        animate={{ opacity: 1, scale: 1 }}
        transition={{ duration: 0.8, delay: 0.1 }}
        className="relative"
      >
        <div className="absolute inset-0 -z-10 rounded-3xl bg-brand-500/20 blur-3xl" />
        <div className="rounded-3xl border border-white/10 bg-white/5 p-6 shadow-2xl backdrop-blur">
          <div className="grid gap-4 sm:grid-cols-2">
            <div className="rounded-2xl bg-slate-900/80 p-5">
              <p className="text-sm text-slate-400">AI Layer</p>
              <p className="mt-2 text-3xl font-semibold text-white">Adaptive</p>
            </div>
            <div className="rounded-2xl bg-slate-900/80 p-5">
              <p className="text-sm text-slate-400">Layout</p>
              <p className="mt-2 text-3xl font-semibold text-white">Organic</p>
            </div>
            <div className="rounded-2xl bg-slate-900/80 p-5">
              <p className="text-sm text-slate-400">Ethics</p>
              <p className="mt-2 text-3xl font-semibold text-white">Transparent</p>
            </div>
            <div className="rounded-2xl bg-slate-900/80 p-5">
              <p className="text-sm text-slate-400">Ready For</p>
              <p className="mt-2 text-3xl font-semibold text-white">2027</p>
            </div>
          </div>
        </div>
      </motion.div>
    </section>
  );
}
EOF

cat <<'EOF' > src/components/Stats/Stats.jsx
import { motion } from "framer-motion";

export default function Stats() {
  return (
    <section className="mx-auto max-w-7xl px-6 py-20">
      <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-4">
        {["Projects", "Clients", "Awards", "AI Models"].map((label, i) => (
          <motion.div
            key={label}
            initial={{ opacity: 0, y: 18 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true, amount: 0.2 }}
            transition={{ duration: 0.45, delay: i * 0.08 }}
            className="rounded-3xl border border-white/10 bg-white/5 p-6 backdrop-blur"
          >
            <p className="text-sm text-slate-400">{label}</p>
            <p className="mt-2 text-3xl font-semibold text-white">00</p>
          </motion.div>
        ))}
      </div>
    </section>
  );
}
EOF

cat <<'EOF' > src/components/Services/Services.jsx
import { motion } from "framer-motion";
import { services } from "../../data/siteContent";

export default function Services() {
  return (
    <section id="services" className="mx-auto max-w-7xl px-6 py-20">
      <div className="mb-10 max-w-2xl">
        <p className="text-sm uppercase tracking-[0.2em] text-slate-400">Services</p>
        <h2 className="mt-3 text-3xl font-bold sm:text-4xl">
          2026–2027 capabilities: AI-first, organic, and ethical
        </h2>
      </div>

      <div className="grid gap-6 md:grid-cols-3">
        {services.map((item, index) => (
          <motion.div
            key={item.title}
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true, amount: 0.2 }}
            transition={{ duration: 0.45, delay: index * 0.08 }}
            className="rounded-3xl border border-white/10 bg-white/5 p-6 backdrop-blur"
          >
            <h3 className="text-xl font-semibold text-white">{item.title}</h3>
            <p className="mt-3 text-slate-300">{item.desc}</p>
          </motion.div>
        ))}
      </div>
    </section>
  );
}
EOF

cat <<'EOF' > src/components/Projects/Projects.jsx
import { motion } from "framer-motion";
import { projects } from "../../data/siteContent";

export default function Projects() {
  return (
    <section id="projects" className="mx-auto max-w-7xl px-6 py-20">
      <div className="mb-10 max-w-2xl">
        <p className="text-sm uppercase tracking-[0.2em] text-slate-400">Projects</p>
        <h2 className="mt-3 text-3xl font-bold sm:text-4xl">Selected work and featured builds</h2>
        <p className="mt-4 text-slate-300">
          Use this section to present your strongest case studies, product work, and client outcomes.
        </p>
      </div>

      <div className="grid gap-6 md:grid-cols-2 xl:grid-cols-3">
        {projects.map((project, index) => (
          <motion.article
            key={project.title}
            initial={{ opacity: 0, y: 24 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true, amount: 0.2 }}
            transition={{ duration: 0.5, delay: index * 0.08 }}
            className="group rounded-3xl border border-white/10 bg-white/5 p-6 backdrop-blur transition hover:border-white/20 hover:bg-white/10"
          >
            <p className="text-sm text-slate-400">{project.category}</p>
            <h3 className="mt-3 text-xl font-semibold text-white">{project.title}</h3>
            <p className="mt-3 text-slate-300">{project.description}</p>

            <div className="mt-5 flex flex-wrap gap-2">
              {project.tech.map((item) => (
                <span
                  key={item}
                  className="rounded-full border border-white/10 bg-slate-900/70 px-3 py-1 text-xs text-slate-300"
                >
                  {item}
                </span>
              ))}
            </div>

            <a
              href={project.link}
              className="mt-6 inline-flex text-sm font-medium text-brand-300 transition group-hover:text-white"
            >
              View project →
            </a>
          </motion.article>
        ))}
      </div>
    </section>
  );
}
EOF

cat <<'EOF' > src/components/About/About.jsx
import { motion } from "framer-motion";

export default function About() {
  return (
    <section id="about" className="mx-auto max-w-7xl px-6 py-20">
      <div className="mb-10 max-w-2xl">
        <p className="text-sm uppercase tracking-[0.2em] text-slate-400">About</p>
        <h2 className="mt-3 text-3xl font-bold sm:text-4xl">
          Built for premium presentation and long-term scalability
        </h2>
      </div>

      <div className="grid gap-6 lg:grid-cols-3">
        {["Focus", "Approach", "Outcome"].map((label, i) => (
          <motion.div
            key={label}
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true, amount: 0.2 }}
            transition={{ duration: 0.45, delay: i * 0.08 }}
            className="rounded-3xl border border-white/10 bg-white/5 p-6 backdrop-blur"
          >
            <p className="text-sm text-slate-400">{label}</p>
            <p className="mt-3 text-lg leading-7 text-white">
              Placeholder text — replace with your narrative.
            </p>
          </motion.div>
        ))}
      </div>
    </section>
  );
}
EOF

cat <<'EOF' > src/components/CaseStudies/CaseStudies.jsx
import { motion } from "framer-motion";

export default function CaseStudies() {
  return (
    <section id="case-studies" className="mx-auto max-w-7xl px-6 py-20">
      <div className="mb-10 max-w-2xl">
        <p className="text-sm uppercase tracking-[0.2em] text-slate-400">Case Studies</p>
        <h2 className="mt-3 text-3xl font-bold sm:text-4xl">
          Show the problem, the process, and the result
        </h2>
      </div>

      <div className="grid gap-6 lg:grid-cols-2">
        {[1, 2].map((i) => (
          <motion.article
            key={i}
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true, amount: 0.2 }}
            transition={{ duration: 0.5, delay: i * 0.1 }}
            className="rounded-3xl border border-white/10 bg-white/5 p-6 backdrop-blur"
          >
            <h3 className="mt-4 text-2xl font-semibold text-white">Case Study {i}</h3>
            <div className="mt-5 space-y-4 text-slate-300">
              <p><span className="text-white">Problem:</span> Placeholder problem.</p>
              <p><span className="text-white">Action:</span> Placeholder action.</p>
              <p><span className="text-white">Result:</span> Placeholder result.</p>
            </div>
          </motion.article>
        ))}
      </div>
    </section>
  );
}
EOF

cat <<'EOF' > src/components/Testimonials/Testimonials.jsx
import { motion } from "framer-motion";
import { testimonials } from "../../data/siteContent";

export default function Testimonials() {
  return (
    <section id="testimonials" className="mx-auto max-w-7xl px-6 py-20">
      <div className="mb-10 max-w-2xl">
        <p className="text-sm uppercase tracking-[0.2em] text-slate-400">Testimonials</p>
        <h2 className="mt-3 text-3xl font-bold sm:text-4xl">
          Add social proof and credibility
        </h2>
      </div>

      <div className="grid gap-6 md:grid-cols-3">
        {testimonials.map((item, index) => (
          <motion.figure
            key={item.name}
            initial={{ opacity: 0, y: 18 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true, amount: 0.2 }}
            transition={{ duration: 0.45, delay: index * 0.08 }}
            className="rounded-3xl border border-white/10 bg-white/5 p-6 backdrop-blur"
          >
            <blockquote className="text-slate-200">“{item.quote}”</blockquote>
            <figcaption className="mt-5 text-sm text-slate-400">
              {item.name} · {item.role}
            </figcaption>
          </motion.figure>
        ))}
      </div>
    </section>
  );
}
EOF

cat <<'EOF' > src/components/Contact/Contact.jsx
import { motion } from "framer-motion";

export default function Contact() {
  return (
    <section id="contact" className="mx-auto max-w-7xl px-6 py-20">
      <div className="grid gap-8 lg:grid-cols-2">
        <div>
          <p className="text-sm uppercase tracking-[0.2em] text-slate-400">Contact</p>
          <h2 className="mt-3 text-3xl font-bold sm:text-4xl">
            Start a conversation about your next portfolio or product build
          </h2>
          <p className="mt-4 max-w-xl text-slate-300">
            Keep the form short and the path simple. Clear contact options usually perform better than cluttered multi-step forms in portfolio sites.
          </p>
        </div>

        <motion.form
          initial={{ opacity: 0, y: 18 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true, amount: 0.2 }}
          transition={{ duration: 0.5 }}
          className="rounded-3xl border border-white/10 bg-white/5 p-6 backdrop-blur"
        >
          <div className="grid gap-4">
            <input
              type="text"
              placeholder="Your name"
              className="rounded-2xl border border-white/10 bg-slate-900/70 px-4 py-3 text-white outline-none placeholder:text-slate-500"
            />
            <input
              type="email"
              placeholder="Email address"
              className="rounded-2xl border border-white/10 bg-slate-900/70 px-4 py-3 text-white outline-none placeholder:text-slate
