# thecore_ui_commons — AI Context

## What this is

A Rails engine gem (v3.3.5) that provides shared UI artifacts for all Thecore-based host applications: layouts, view partials, Sprockets assets, ECharts helpers, and Swagger versioning support.

## Running tests

```bash
bundle exec ruby -Itest test/thecore_ui_commons_test.rb
bundle exec ruby -Itest test/integration/swagger_test.rb
```

`DATABASE_URL` is forced to SQLite3 inside `test_helper.rb` — no env var needed.

## Key files

| File | Purpose |
|---|---|
| `lib/thecore_ui_commons.rb` | Module entry point; declares `mattr_accessor :swagger_api_versions` |
| `lib/thecore_ui_commons/engine.rb` | Engine; `config.after_initialize` scans routes and sets `swagger_api_versions` |
| `app/controllers/info_controller.rb` | Serves Swagger UI page at `/info/swagger/:version` |
| `app/views/info/swagger.html.erb` | Swagger UI view; server-rendered version nav via `content_for :version_nav` |
| `app/views/layouts/swagger.html.erb` | Minimal layout; `yield :version_nav` slot sits above `#swagger-ui` |
| `config/routes.rb` | `/info/swagger` (301 → v2) + `/info/swagger/:version` |
| `docs/adr/` | Architecture decisions |
| `CONTEXT.md` | Domain glossary — canonical terms for this codebase |

## Architecture to know

**Swagger versioning** — `model_driven_api` (a separate gem, not declared here) provides `api/vN/info/swagger.json` endpoints in host apps. At startup, `config.after_initialize` scans `Rails.application.routes` for paths matching `api/vN/info/swagger`, extracts the version identifiers, sorts them numerically, and stores them in `ThecoreUiCommons.swagger_api_versions`. The controller reads this to render the Version Nav Banner server-side — no client-side probing.

**Swagger layout** — has no Bootstrap or jQuery. The Swagger UI topbar is hidden via CSS (`display: none`). Custom CSS only. The `params[:version]` value is sanitized (`gsub(/[^a-zA-Z0-9]/, '')`) before use in URLs or JS.

**ECharts helpers** — plain Ruby classes in `lib/echarts/` (`Vector`, `MultipleVectors`, `Binary`, `BinarySeries`, `Speedometer`, `Map`). They return Apache ECharts-compatible config hashes. Host apps call them server-side and pass the result to the frontend.

## Conventions

- Domain language lives in `CONTEXT.md` — check it before introducing new terms.
- Architecture decisions live in `docs/adr/` — check before reversing a non-obvious choice.
- No comments unless the *why* is non-obvious from the code.
- No Bootstrap in the Swagger layout; keep it dependency-free.

## CI/CD — gem publish (`.github/workflows/gempush.yml`)

The RubyGems publish workflow's `on: push` trigger is scoped to `branches: [release/3]` only, not an unscoped `push`. This was tightened after an incident on a sibling repo (`thecore_generators`) where an unscoped trigger published a version bump pushed to an unreviewed feature branch. Keep the trigger scoped to `release/3` so publishing only ever happens on a merge/push to the actual release branch.
