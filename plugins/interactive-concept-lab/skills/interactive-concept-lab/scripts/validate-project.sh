#!/usr/bin/env bash
# Installs, type-checks, tests and builds a concept lab, then checks that the
# build is one self-contained dist/index.html. Usage: validate-project.sh <project-dir>
set -euo pipefail
dir="${1:?usage: validate-project.sh <project-dir>}"
cd "$dir"

step() { printf '\n== %s\n' "$1"; }
fail() { echo "FAIL: $1"; exit 1; }

step "install";    npm install --no-audit --no-fund
step "typecheck";  npx tsc -b
if npm run | grep -qE '^  test$'; then
  step "test";     npm test -- --run
else
  fail "no \"test\" script in package.json"
fi
step "build";      npx vite build

step "single file"
[ -f dist/index.html ] || fail "dist/index.html was not built"
extra=$(find dist -type f ! -path dist/index.html)
[ -z "$extra" ] || fail "dist/ must hold only index.html. Add vite-plugin-singlefile to vite.config.ts, and import assets from src/ instead of public/:
$extra"
if grep -qE '<script[^>]*\ssrc=|<link[^>]*rel="?(stylesheet|modulepreload)' dist/index.html; then
  fail "dist/index.html still loads external scripts or stylesheets"
fi
echo "dist/index.html is self-contained ($(wc -c < dist/index.html | tr -d ' ') bytes)"

echo
echo "OK: $dir installs, type-checks, tests and builds to a single dist/index.html"
