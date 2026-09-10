---
name: rudderstack-tool
source_path: /Users/love/agent-guides/rudderstack-plg-guide.md
official_docs: https://www.rudderstack.com/docs/
---

# RudderStack CLI/API card

## Auth

- `rudder-cli auth login` for CLI configuration work.
- Source write key authenticates event intake; it is not workspace admin access.
- Control Plane API credentials are separate and must remain environment-backed.

## High-leverage commands

```bash
rudder-cli validate -l rudderstack
rudder-cli diff -l rudderstack
rudder-cli apply -l rudderstack --confirm=false
```

For destinations/connections, use the documented Control Plane API when the CLI spec does not cover the resource. Verify with source/destination live events and then the warehouse.

## Common errors

- Missing local spec directory: run from the directory containing the YAML or pass its real path.
- HTTP 200: intake accepted only; it does not prove warehouse delivery.
- Event name appears normalized in warehouse: inspect both display text and stored event field.
