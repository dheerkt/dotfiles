---
description: Adversarial review — bugs, trash tests, slop, and architecture assessment
---

Run an adversarial code review on all changes in this session (per-commit if multiple commits, each as a separate background code-reviewer agent). While that runs, also answer:
1. Are there any trash tests that test mock/framework behavior rather than real functionality? If so, identify them — they should be removed or rewritten to test real behavior per TDD antipatterns.
2. Is there any AI slop — overly verbose comments, over-engineering, or code that could be simplified without losing functionality?
3. Do the changes improve or detract from the codebase architecture and beauty?
4. Quick self-review: review the whole diff of all changes so far and answer: have we used DRY and simplification principles effectively? Can the code be better organized? Are there any antipatterns? Pass these findings and the relevant file paths to a separate background code-reviewer agent. Ask it to validate each one against the code and say which are necessary.

After the reviews return, fix the critical and important findings and the validated self-review findings, then continue.
