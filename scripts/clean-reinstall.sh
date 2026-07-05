#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="${1:-.}"
KEEP_LOCKFILE="${KEEP_LOCKFILE:-0}"
LOG_DIR="$ROOT_DIR/logs"
LOG_FILE="$LOG_DIR/tailwind-check.log"

mkdir -p "$LOG_DIR"
touch "$LOG_FILE"

log() {
  local msg="$1"
  local line="[$(date -Iseconds)] $msg"
  echo "$line" | tee -a "$LOG_FILE"
}

cd "$ROOT_DIR"

log "Cleaning Vite/Tailwind project at: $ROOT_DIR"

if [ -d "node_modules" ]; then
  rm -rf node_modules
  log "Removed node_modules"
fi

if [ -d "dist" ]; then
  rm -rf dist
  log "Removed dist"
fi

if [ -d "node_modules/.vite" ]; then
  rm -rf node_modules/.vite
  log "Removed Vite cache"
fi

if [ "$KEEP_LOCKFILE" != "1" ] && [ -f "package-lock.json" ]; then
  rm -f package-lock.json
  log "Removed package-lock.json"
fi

if [ -f "npm-debug.log" ]; then
  rm -f npm-debug.log
  log "Removed npm-debug.log"
fi

log "Reinstalling dependencies..."
npm install
log "Reinstall complete"
