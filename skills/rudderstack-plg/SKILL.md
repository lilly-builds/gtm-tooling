---
name: rudderstack-plg
description: Use when a product signal must be identified, tracked, or routed through RudderStack.
uses: [tools/rudderstack, knowledge/rudderstack-plg]
auth_prerequisite: RudderStack workspace access and source write key only when sending; Control Plane write auth only for configuration changes.
entry: An approved event contract and an existing or intentionally new source are known.
exit: A test identify/track is accepted, visible at the source, and routing evidence is recorded.
guard: If a source, destination, or write key is missing, inspect before creating anything; do not guess credentials.
bound: Stop after one bounded test signal and ask a human before paid resources, destructive changes, or production activation.
---

# RudderStack PLG skill

1. Read the event contract in the knowledge node.
2. Check existing source and destination state with CLI/API before changing configuration.
3. Use the official Node SDK or HTTP API with environment variables; never hardcode secrets.
4. Send `identify` for the person/account relationship and `track` for the product action.
5. Verify HTTP acceptance, source live events, destination delivery, and warehouse landing separately.
6. Report the truth boundary: a client flag is not proof of first-ever success.
