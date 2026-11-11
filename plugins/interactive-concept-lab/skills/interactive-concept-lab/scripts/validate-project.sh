#!/usr/bin/env bash
# Installs, type-checks, tests and builds a concept lab. Usage: validate-project.sh <project-dir>
set -euo pipefail
dir="${1:?usage: validate-project.sh <project-dir>}"
cd "$dir"

step() { printf '\n== %s\n' "$1"; }

step "install";    npm install --no-audit --no-fund
step "typecheck";  npx tsc -b
if npm run | grep -qE '^  test$'; then
  step "test";     npm test -- --run
else
  echo "FAIL: no \"test\" script in package.json"; exit 1
fi
step "build";      npx vite build

echo
echo "OK: $dir installs, type-checks, tests and builds"
