# Client-side sequential probing for Swagger version discovery

**Status**: superseded by [ADR-0002](0002-server-side-route-introspection-for-swagger-version-discovery.md)

The Swagger UI page needs to discover which API versions (`/api/vN/info/swagger.json`) the host app exposes, without the engine knowing or being configured with that list. We chose client-side sequential HEAD requests starting from `v2`, stopping on the first non-200 response. The Swagger UI for the current version loads immediately and in parallel — the version discovery runs in the background and resolves into a Version Nav Banner above the UI.

## Considered options

- **Server-side probing in the controller** — rejected because it adds latency before the user sees any API docs; the Swagger UI is blocked until all probes complete.
- **Explicit engine config** (`ThecoreUiCommons.swagger_versions`) — rejected because it requires host apps to stay in sync with their own routes; the probe is the authoritative source of truth.
- **Hardcoded routes** (`/info/swagger/v2`, `/info/swagger/v3`) — rejected because adding a new version would require a gem update.
- **Parallel probing up to a ceiling** — rejected because results arrive out of order, making the progress modal harder to read; sequential probing produces a natural top-to-bottom checklist.
