"""A working DeepEval example, to show the API. It checks tone only.

It is deliberately unrelated to correctness: it does not look at the policy and says nothing
about which answers are right. Copy the pattern; replace the criteria with your own.
Skipped automatically when ANTHROPIC_API_KEY is not set.
"""
from deepeval.metrics import GEval
from deepeval.test_case import LLMTestCase, SingleTurnParams


def test_example_response_is_polite(judge, prompts, responses):
    response = next(r for r in responses if r["id"] == "P1-v1")

    metric = GEval(
        name="Politeness",
        criteria="The response is courteous and professional, with no rude or dismissive language.",
        evaluation_params=[SingleTurnParams.ACTUAL_OUTPUT],
        model=judge,
        threshold=0.5,
    )
    case = LLMTestCase(
        input=prompts[response["prompt_id"]]["customer_message"],
        actual_output=response["text"],
    )

    metric.measure(case)
    assert metric.is_successful(), metric.reason
