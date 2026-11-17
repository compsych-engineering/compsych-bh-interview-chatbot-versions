"""Proves the fixtures load. Says nothing about response quality."""


def test_fixtures_load(prompts, responses):
    assert set(prompts) == {"P1", "P2", "P3", "P4"}
    assert len(responses) == 8
    assert {r["version"] for r in responses} == {"v1", "v2"}
    assert all(r["prompt_id"] in prompts and r["text"].strip() for r in responses)
