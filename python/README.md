# Starter (optional)

A small pytest project so you don't spend time on plumbing. Use it, adapt it, or ignore it.

## Quick start

macOS / Linux / WSL / Git Bash:

```bash
cd python
bash setup.sh
```

Windows (Command Prompt or PowerShell):

```bat
cd python
.\setup.cmd
```

The script creates a virtualenv (`.venv`), installs the dependencies, and asks for your Anthropic
API key. It does not run the tests. The key is optional: press Enter to skip it and the judge
example is skipped. If you enter one, it is saved to `python/.env` (git-ignored; owner-readable
only on macOS/Linux) and the input is not shown on screen. Re-running the script is safe; it won't
overwrite an existing key.

Your interviewer will give you a short-lived key. Don't commit it or paste it anywhere else.

Then run the tests (`bash run-tests.sh`, or `.\run-tests.cmd` on Windows):

```bash
bash run-tests.sh
```

Expected output at the end:

- No key: `1 passed, 1 skipped`. The skip message says `ANTHROPIC_API_KEY not set`. This is normal.
  `test_smoke` passing means the fixtures load.
- With a valid key: `2 passed`. The example makes one Claude call, so it takes a few seconds.

If you see `401 ... invalid x-api-key`, the key is wrong or expired. Delete `python/.env`, re-run
the setup script, run the tests again, and ask your interviewer if it still fails. To add a key
later, delete `.env` (if there is one) and re-run the script.

The test script activates the virtualenv for you and passes extra arguments to pytest (for
example `bash run-tests.sh -k smoke` or `.\run-tests.cmd -k smoke`). To work in the environment
yourself: `source .venv/bin/activate` (Windows: `.venv\Scripts\activate`).

### Doing it by hand

```bash
python3 -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt
cp .env.example .env     # then paste the key after ANTHROPIC_API_KEY=, no quotes or spaces
pytest -rs
```

Without a `.env`, or with the key line empty, judge-based tests skip.

## What's here

| File | Purpose |
|---|---|
| `setup.sh` / `setup.cmd` | Creates the virtualenv, installs dependencies, saves your key |
| `run-tests.sh` / `run-tests.cmd` | Runs the tests inside the virtualenv |
| `harness/loader.py` | `load_prompts()`, `load_responses()` |
| `harness/judge.py` | Builds a Claude judge for DeepEval from `ANTHROPIC_API_KEY` |
| `conftest.py` | Pytest fixtures: `prompts`, `responses`, `judge` |
| `tests/test_smoke.py` | Confirms the fixtures parse |
| `tests/test_example.py` | A working DeepEval `GEval` metric, as an API example only |

The example checks politeness. It doesn't check whether answers are right; that part is yours.

Judge calls cost money and take a few seconds each, so be deliberate about how many you make.
You don't have to use DeepEval or the judge. Any approach is fine.
