---
title: RudderStack PLG knowledge
source_path: /Users/love/agent-guides/rudderstack-plg-guide.md
official_docs: https://www.rudderstack.com/docs/
---

# RudderStack mental model

RudderStack is the customer data platform (CDP) middle layer. Product code emits events; RudderStack accepts, routes, and delivers them to a warehouse.

## EAS signal contract

- `identify(userId, { email, orgId, plan })` answers who acted and which organization owns the user.
- `track("EAS Build Succeeded", { orgId, projectId, platform, isFirstSuccess })` answers what happened.
- A stable `eventId` and `buildId` belong in the production contract.
- Product code must decide first-ever success from durable build history. The warehouse must not invent it from a test flag.

## Verification ladder

1. Product eligibility: product logic decides whether this is the first durable success.
2. Pipeline delivery: HTTP acceptance, source live event, destination attempt, and warehouse row.
3. Analytics truth: dbt flags duplicates, missing identity, late delivery, and creates one organization record.
4. Activation: a reviewed account score routes into a customer relationship management (CRM) tool.

Do not confuse an HTTP 200 with warehouse landing. Identify and track are different facts, and one user action can create rows in multiple warehouse tables.
