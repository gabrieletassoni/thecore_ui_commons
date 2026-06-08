# Server-side route introspection for Swagger version discovery

Supersedes [ADR-0001](0001-client-side-swagger-version-discovery.md).

The API routes (`api/vN/info/swagger`) are provided by the `model_driven_api` gem, which means the host app's route set is the authoritative source of truth for which versions exist. We use `Rails.application.routes` introspection inside `config.after_initialize` in `ThecoreUiCommons::Engine` to scan for paths matching `api/vN/info/swagger`, extract the version identifiers, and store them in `ThecoreUiCommons.swagger_api_versions`. The Version Nav Banner is then rendered server-side in ERB — no JavaScript probing, no discovery modal.

## Why this supersedes ADR-0001

ADR-0001 rejected server-side approaches because of HTTP round-trip latency. Route introspection is not HTTP probing — it is an in-process scan of an already-loaded data structure, costing microseconds. The original objection does not apply here. Route introspection is also more authoritative than HTTP probing: a route that exists in `Rails.application.routes` is guaranteed to be routable, whereas an HTTP HEAD request could fail for transient reasons unrelated to whether the version exists.

## Considered options

- **Client-side sequential HTTP probing** (ADR-0001) — rejected because it requires a discovery modal, adds JavaScript complexity, and the probing is unreliable (transient network errors, CORS, timeouts). Route introspection makes it unnecessary.
- **Explicit engine config** (`ThecoreUiCommons.swagger_versions = [...]`) — rejected because it requires host apps to manually stay in sync with their own mounted routes.
