"""Plumbing: build a Claude judge for DeepEval from ANTHROPIC_API_KEY."""
import os

DEFAULT_MODEL = "claude-haiku-5-5"


def judge_available() -> bool:
    return bool(os.environ.get("ANTHROPIC_API_KEY"))


def build_judge():
    """Return a DeepEval model that calls Claude. (No temperature: the current Anthropic SDK rejects it.)"""
    from deepeval.models import AnthropicModel

    return AnthropicModel(
        model=os.environ.get("CLAUDE_JUDGE_MODEL", DEFAULT_MODEL),
        api_key=os.environ["ANTHROPIC_API_KEY"],
    )
