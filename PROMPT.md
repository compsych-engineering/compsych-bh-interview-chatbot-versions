# Evaluating an AI Assistant Whose Answers Vary

**Time:** 60 minutes: ~5 min framing, ~35 min working, ~20 min discussion.
**Stack:** your choice. A Python starter is provided if you want it; it is optional.
**AI tooling:** allowed and expected. See [How we work](#how-we-work).

## Context

ComPsych is testing a new version of an AI assistant that answers employee questions about
their Employee Assistance Program (EAP) benefits. The assistant's wording differs from one run
to the next, even for the same question. Before the new version (**v2**) replaces the current one
(**v1**), someone has to decide whether it's ready. You are that person.

A wrong answer here has real consequences: an employee told the wrong reimbursement amount may
pay for care they believed was covered, or skip care they were entitled to.

## The policy

This fictional policy is the source of truth for judging every response.

**Meridian EAP: Therapy Session Reimbursement Policy.**
Your employer pays for counseling sessions through the Employee Assistance Program (EAP). This policy explains when an employee can be reimbursed for sessions they paid for themselves.

 1. **Coverage.** The EAP covers up to **6 sessions per issue per plan year** with an
    in-network provider. In-network providers normally bill Meridian directly. If an employee
    pays up front anyway, a covered session is reimbursed **in full**.
 2. **Out-of-network providers.** Sessions with an out-of-network provider are reimbursed
    only if Meridian **authorized them before the first session**, and only up to
    **$100 per session**. Any amount above $100 is the employee's responsibility.
 3. **Claim deadline.** Claims must be submitted within **60 days** of the session date.
 4. **Session limit.** Sessions beyond 6 for the same issue are not covered. A different
    issue starts a new count of 6.
 5. **Late cancellations.** Sessions cancelled with less than 24 hours' notice, and missed
    sessions (no-shows), are not covered.
 6. **Dependents.** The employee and each eligible dependent have their own allowance
    of 6 sessions per issue per plan year.
 7. **No fees.** No copay, processing fee, or administrative charge is ever applied to a
    covered claim.

## What you're given

The data files are in `fixtures/`:

| File | Contents |
|---|---|
| `prompts.json` | Four customer questions, `P1` to `P4`. |
| `responses.json` | One saved response from each version for each prompt: 8 in total. Each has an `id`, `prompt_id`, `version` and `text`. |

The responses are saved data. Nothing in this exercise calls the assistant.

## Ground rules for judging a response

We aren't giving you an answer key. You decide what's correct, using these rules:

- **The policy is the only source of truth.** A statement is accurate if the policy says it, or
  it follows from the policy and the customer's own message (including simple arithmetic).
- **The customer's message is the only information about the customer.** Nothing else is known
  about them. If a fact isn't in the message, the assistant doesn't know it either.
- **A statement the policy doesn't support is a problem to evaluate.** Decide for yourself how
  much it matters, and say why.
- **Different wording isn't a different answer.**

Examples, using statements that are *not* in the saved responses:

| A response says | Verdict |
|---|---|
| "Sessions cancelled with under 24 hours' notice aren't covered." | Accurate. Rule 5 says so. |
| "Each dependent has their own allowance of 6 sessions." | Accurate. Rule 6. |
| "Sessions cancelled with under 48 hours' notice aren't covered." | Unsupported. The policy says 24. |
| "Your therapist is excellent." | Not a policy claim. Irrelevant to correctness. |

## What to do

1. **Write a short scoring guide** for judging responses to questions like these. One page at
   most. Another engineer should be able to apply it and reach the same verdict you would.
2. **Apply it** to a few responses of your choosing, and show your reasoning.
3. **Implement one automated check** that runs against the saved responses. You pick what it
   checks. It should be something a team could run on every new version.
4. **Make a release call.** Using what you've found, say whether you'd ship v2, hold it, or ship
   with conditions, and what would make you hold the release. Each saved response is a single run
   of the assistant. Then tell us how you would use repeated runs to tell a real regression from
   normal variation.

You will not finish all of this in the time, and that's by design. Pick what matters, and say why.

## Starter (optional)

`python/` has a small pytest project: loaders for the fixtures, a working example of a
[DeepEval](https://deepeval.com) metric, and a smoke test. See `python/README.md`.

The example metric uses Claude as a judge. If you run it, you'll be given an API key by the
interviewer, which you put in `python/.env` as `ANTHROPIC_API_KEY`. The key is short-lived and
for this session only. You can ignore the example metric and the judge entirely.

## How we work

**Use AI tools as much as you like.** We're evaluating how you direct them, check what comes
back, and decide what to trust, not how fast you type.

Please think out loud. We want to hear:

- What counts as a correct answer, and what counts as just a different one.
- Which mistakes you treat as serious, and why.
- What you hand to the AI, and what context you give it.
- How you check what comes back, including anything you changed or rejected.
- The trade-offs in how you built your check.

It's fine to pause and think. Silence for ten minutes is the only thing that costs you.

## Questions

Ask them. Some things in this brief are deliberately open, and we'd rather you notice and decide
than quietly assume.
