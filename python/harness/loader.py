"""Plumbing: read the fixtures. No evaluation logic lives here."""
import json
from pathlib import Path

FIXTURES = Path(__file__).resolve().parents[2] / "fixtures"


def load_prompts() -> dict[str, dict]:
    """Prompts keyed by id (P1..P4)."""
    return {p["id"]: p for p in json.loads((FIXTURES / "prompts.json").read_text())}


def load_responses() -> list[dict]:
    """Every saved response: id, prompt_id, version ('v1'|'v2'), text."""
    return json.loads((FIXTURES / "responses.json").read_text())
