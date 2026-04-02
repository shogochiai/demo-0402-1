# IP Cancel CLI

`etherclaw ip cancel <ipId>` invokes `cancelIpProposal` for the target `ipId`.

## Operator Flow

1. Resolve the active proposal by `ipId`.
2. Encode the `cancelIpProposal` request with the proposal `ipId`.
3. Submit the request as the proposal author.
4. Report the resulting `cancelled` proposal state back to the operator.

## Request / Response

- Method: `cancelIpProposal`
- Input: JSON text containing `ipId`
- Example: `{"ipId": 41}`
- Success: returns the `ipId` of the cancelled proposal
- Failure: rejects non-author callers, finalized proposals, and proposals whose voting finalization already ended
