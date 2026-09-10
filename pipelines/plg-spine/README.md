# PLG spine MVP

This is the verified local path:

```text
TypeScript sender → RudderStack → ClickHouse → dbt → PQA account score
```

## Run

```bash
cp .env.example .env.local
# Fill .env.local locally; do not commit it.
npm install
npm run send:eas-build-succeeded
python3.12 -m venv .venv
.venv/bin/pip install -r requirements.txt
set -a; source .env.local; set +a
.venv/bin/dbt debug --project-dir analytics --profiles-dir analytics
.venv/bin/dbt run --project-dir analytics --profiles-dir analytics --threads 1
.venv/bin/dbt test --project-dir analytics --profiles-dir analytics --threads 1
```

Explain an account decision after the run:

```bash
./explain-account.sh org_test_123
```

The dbt models are views for the sandbox. A successful model run does not prove first-ever success; the sender's flag is still a trusted prototype input. HubSpot routing is not enabled yet, so this explains the score and recommended status rather than writing to a CRM.
