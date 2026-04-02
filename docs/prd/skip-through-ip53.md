# Skip legacy backlog through IP-53

## Goal

Allow Colony to ignore all finalized IP proposals up to and including `IP-53`,
so the next fresh demo IP becomes the first executable target.

## Scope

- This is a Colony control proposal.
- Colony must not generate a TaskTree for this proposal itself.
- Colony must read and apply the skip rule before evaluating normal IPs.

## Machine-readable control block

SKIP_IP_RANGE: 1-53

## Acceptance

- Colony treats `IP-1` through `IP-53` as excluded from execution.
- Colony continues processing normal finalized IPs after applying the skip range.
- This proposal is recognized as control metadata, not product work.
