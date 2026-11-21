---
name: deep-research
description: Research a topic, investigate a question, or compare options using public sources and workspace evidence. Use when the user asks for deep research or an evidence-based recommendation.
---

# Deep Research

## Overview

Investigate the question thoroughly and verify conclusions against multiple sources.

## Usage

Use for open-ended research, technical investigations, and comparisons that need more than one source. Do the research directly; do not delegate it to explore agents.

Use public sources and files in the workspace only. Do not query company-internal systems or knowledge bases.

## Core Concepts

- Use three or four relevant source types when available: official documentation, source code, standards or papers, issue trackers, and practitioner reports.
- Prefer primary sources and inspect the full source when a search result is promising or truncated.
- Compare evidence across sources. Check versions and dates when they affect the conclusion. Distinguish verified facts from inference and note gaps or disagreements.

## Workflow

1. Identify the research question and useful source types. Use public search, source fetches, and relevant workspace files. Parallelize independent lookups when possible.
2. Look at implementation, alternatives, tradeoffs, and real-world pitfalls. Follow up on missing or conflicting evidence before drawing conclusions.
3. Report the main findings with source links, concrete details for each option, a reasoned recommendation when appropriate, and any unresolved questions.
