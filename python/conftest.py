import os
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).parent))

from dotenv import load_dotenv

load_dotenv(Path(__file__).parent / ".env")
os.environ.setdefault("DEEPEVAL_TELEMETRY_OPT_OUT", "YES")

from harness import judge as _judge  # noqa: E402
from harness.loader import load_prompts, load_responses  # noqa: E402


@pytest.fixture(scope="session")
def prompts():
    return load_prompts()


@pytest.fixture(scope="session")
def responses():
    return load_responses()


@pytest.fixture(scope="session")
def judge():
    """Claude judge for DeepEval metrics. Tests that use it skip if no key is set."""
    if not _judge.judge_available():
        pytest.skip("ANTHROPIC_API_KEY not set; judge-based test skipped")
    return _judge.build_judge()
