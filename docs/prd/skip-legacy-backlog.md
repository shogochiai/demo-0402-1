# 1. Intro & Goal

**Title:** Skip Proposal: 1-40

**Goal:** Exclude legacy finalized IP ranges from Colony processing so the live demo can focus on the current batch.

# 2. Concept / Value Proposition

This proposal is a control proposal for Colony. Once finalized, Colony must read the declared skip ranges before compiling regular finalized IPs into TaskTrees.

# 3. Product Vision

Governance should be able to steer Colony's attention during a demo or incident without mutating historical finalized proposals.

# 4. Who's it for?

- Shareholders running a controlled live demo
- Operators who need to quarantine legacy backlog ranges

# 5. Why build it?

Shared TheWorld instances accumulate finalized proposals across runs. A strict skip proposal lets governance exclude stale ranges without resetting the world state.

---

# 11. Tech Notes

kind = skip_proposal
skip_range = 1-40
