#!/usr/bin/env bash
# Run the test suite inside the virtualenv created by setup.sh.
#   bash run-tests.sh            all tests
#   bash run-tests.sh -k smoke   extra arguments are passed to pytest
set -euo pipefail
cd "$(dirname "$0")"

if [ ! -d .venv ]; then
  echo "No .venv found. Run:  bash setup.sh" >&2
  exit 1
fi
# shellcheck disable=SC1091
source .venv/bin/activate 2>/dev/null || source .venv/Scripts/activate

if ! pytest -rs "$@"; then
  echo >&2
  echo "Tests failed. If you see '401 ... invalid x-api-key', the key is wrong or expired:" >&2
  echo "delete python/.env, re-run  bash setup.sh,  and ask your interviewer for a new key if needed." >&2
  exit 1
fi
