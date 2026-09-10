# TODO

- Add a real HubSpot activation node and approval-gated reverse sync.
- Replace the sender's trusted `isFirstSuccess` input with product-side durable build history, stable build IDs, and an idempotent outbox.
- Add a committed dbt source freshness policy and a negative/recovery test for late or duplicate delivery.
- Configure the private remote if this local repository is not already connected to one.
