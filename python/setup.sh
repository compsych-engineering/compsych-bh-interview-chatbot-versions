#!/usr/bin/env bash
# One-step setup: virtualenv, dependencies, optional API key. Then run: bash run-tests.sh
# Run from anywhere:  bash setup.sh      (macOS / Linux / WSL / Git Bash)
set -euo pipefail
cd "$(dirname "$0")"

if ! command -v python3 >/dev/null 2>&1; then
  echo "python3 not found. Install Python 3.10+ and re-run." >&2
  exit 1
fi

echo "==> Creating virtualenv (.venv) and installing dependencies..."
[ -d .venv ] || python3 -m venv .venv
# shellcheck disable=SC1091
source .venv/bin/activate 2>/dev/null || source .venv/Scripts/activate
pip install -q --disable-pip-version-check -r requirements.txt

echo
if [ -s .env ] && grep -q '^ANTHROPIC_API_KEY=.\+' .env; then
  echo "==> .env already contains a key; leaving it alone. (To replace it, delete python/.env and re-run.)"
else
  echo "==> Anthropic API key (optional; only needed for the Claude judge example)."
  echo "    Paste the key your interviewer gave you, or press Enter to skip."
  read -r -s -p "    Key: " key || key=""
  echo
  # Trim whitespace and stray quotes from pasting.
  key="$(printf '%s' "$key" | tr -d '[:space:]"'"'")"
  if [ -n "$key" ]; then
    umask 077
    printf 'ANTHROPIC_API_KEY=%s\n' "$key" > .env
    echo "    Saved to python/.env (git-ignored)."
  else
    echo "    Skipped. The judge example will be skipped too. You can re-run this script later."
  fi
fi

echo
echo "Setup complete. Run the tests with:  bash run-tests.sh"
