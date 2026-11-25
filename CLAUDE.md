# thecore_ui_commons — AI Context

## What this is

A Rails engine gem (v3.5.0, Rails 7.2 or 8.1; the suite runs on 8.1) that provides shared UI artifacts for all Thecore-based host applications: layouts, view partials, Sprockets assets, ECharts helpers, and Swagger versioning support.

## Running tests

```bash
bin/test                                          # full suite, Rails 8.1
bin/test test/integration/omniauth_csrf_test.rb   # one file
# same suite on Rails 7.2.4 (best effort, not in CI); plain `bundle update rails` goes back to 8.1
RAILS_VERSION=7.2 bundle update rails && RAILS_VERSION=7.2 bin/test
```

The `Gemfile` pins the Rails line (`RAILS_LINE`) and minitest 5; `Gemfile.lock` is gitignored, so after a gemspec change verify with `rm Gemfile.lock && bundle install`. With `JUNIT_REPORT_DIR` set, `test/support/junit_report.rb` writes a JUnit XML report (CI).

**omniauth-rails_csrf_protection** (`>= 1.0, < 3`): this gem requires it, so OmniAuth's request phase (`POST /auth/:provider`) checks the Rails CSRF token. 2.x is the one without the `ActiveSupport::Configurable` deprecation on Rails 8.1; `test/integration/omniauth_csrf_test.rb` covers the check and the clean boot.

**Locked users**: this gem does nothing about them. thecore_auth_commons (`~> 3.7, >= 3.7.1`, a direct dependency for this reason) refuses a locked user on every login channel exactly like a wrong password; `test/integration/locked_user_sign_in_test.rb` checks the sign-in form gives a locked user the wrong-password answer (401, same alert). Up to 3.4.0 a `reject_locked!` before_action signed them out with "Your account is locked." (host Odoo #6259). The test helper builds the test database from the migrations the engines add to `db/migrate` (the dummy has none of its own); the dev `Gemfile` has `sassc-rails` to compile the sign-in layout's SCSS, as the host apps do.

Tests run on **PostgreSQL only** (the sole DB target of all Thecore gems and host apps — never SQLite). `test/dummy/config/database.yml` uses the `postgresql` adapter (`PGHOST`/`PGPORT`/`PGUSER`/`PGPASSWORD`, defaulting to `db`/`5432`/`postgres`/`postgres`) with databases `thecore_ui_commons_{development,test,production}`. When `DATABASE_URL` is set (the devcontainer points it at the host app's dev DB), `test/dummy/config/boot.rb` keeps its server/credentials but rewrites the database name to `thecore_ui_commons_<RAILS_ENV>`, so no entry point (tests, `bin/rails db:*`, `db:test:prepare`) can ever touch the host's databases. One-time setup: `cd test/dummy && RAILS_ENV=test bin/rails db:create`.

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
| `GLOSSARY.md` | Domain glossary — canonical terms for this codebase |

## Architecture to know

**Swagger versioning** — `model_driven_api` (a separate gem, not declared here) provides `api/vN/info/swagger.json` endpoints in host apps. At startup, `config.after_initialize` scans `Rails.application.routes` for paths matching `api/vN/info/swagger`, extracts the version identifiers, sorts them numerically, and stores them in `ThecoreUiCommons.swagger_api_versions`. The controller reads this to render the Version Nav Banner server-side — no client-side probing.

**Swagger layout** — has no Bootstrap or jQuery. The Swagger UI topbar is hidden via CSS (`display: none`). Custom CSS only. The `params[:version]` value is sanitized (`gsub(/[^a-zA-Z0-9]/, '')`) before use in URLs or JS.

**ECharts helpers** — plain Ruby classes in `lib/echarts/` (`Vector`, `MultipleVectors`, `Binary`, `BinarySeries`, `Speedometer`, `Map`). They return Apache ECharts-compatible config hashes. Host apps call them server-side and pass the result to the frontend.

## Conventions

- Domain language lives in `GLOSSARY.md` — check it before introducing new terms.
- Architecture decisions live in `docs/adr/` — check before reversing a non-obvious choice.
- No comments unless the *why* is non-obvious from the code.
- No Bootstrap in the Swagger layout; keep it dependency-free.

## CI/CD — test and gem publish (`.github/workflows/gempush.yml`)

Two jobs: `test` runs `bin/test` on PostgreSQL 15 (Ruby 3.3) on every push and pull request on `release/3`; `publish` (`needs: test`, pushes only) builds and pushes the gem, then tags the version and creates its GitHub release with the JUnit report attached. A version whose tag exists is skipped. If a rerun finds the version already on RubyGems (the tag push failed after the gem push), it skips the push and creates the tag and the release.

The RubyGems publish workflow's `on: push` trigger is scoped to `branches: [release/3]` only, not an unscoped `push`. This was tightened after an incident on a sibling repo (`thecore_generators`) where an unscoped trigger published a version bump pushed to an unreviewed feature branch. Keep the trigger scoped to `release/3` so publishing only ever happens on a merge/push to the actual release branch.

## Security scanning

Configured in the GitHub repository settings, not in files:

- **CodeQL** default setup (Ruby, the Actions workflows, and JavaScript/TypeScript where the gem
  ships any): on every push to `release/3`, on pull requests and weekly. Findings: Security → Code
  scanning.
- **Secret scanning with push protection**: a push containing a recognised secret is rejected. It
  is the only check that blocks anything. If it fires on a real secret, remove it from the commit and
  rotate the secret; never bypass it.
- **Dependabot alerts and security updates**, but no `dependabot.yml`, so no routine version-bump
  pull requests. This gem commits no `Gemfile.lock`, so Dependabot only sees the gemspec and the
  workflow Actions: CVEs in the resolved Ruby dependencies are caught by `bundler-audit` in the host
  apps' pipelines, whose `Gemfile.lock` resolves every ATOM.
- Findings never block a release: GitHub notifies the owner. When one needs work, open a GitHub
  issue (see Agent skills).
- `config/brakeman.ignore` (for a local `brakeman` run) records the High `ForgerySetting` on
  `ApplicationController` as a false positive: `ConcernCommonApplicationController`, included at
  boot by `config/initializers/after_initialize.rb`, calls `protect_from_forgery prepend: true`.
  Each entry's `note` says why.

## Agent skills

### Issue tracker

Tasks, issues, bugs, tickets and specs for this repository live **only** in its GitHub Issues
(`gabrieletassoni/thecore_ui_commons`), handled with the `gh` CLI. See `docs/agents/issue-tracker.md`.

**Mandatory rule.** Whenever a skill or development work creates, reads, updates, comments on,
assigns, blocks or closes a task, issue, bug, ticket or spec (for example /to-tickets, /to-spec,
/triage, /wayfinder, /implement, /diagnosing-bugs, /code-review, closing a piece of work, a bug found
during a session), do it in this repository's GitHub Issues following `docs/agents/issue-tracker.md`.
Never use Odoo, `.scratch/` or local Markdown files as a tracker: Odoo is only for the repositories
on Bancolini's GitLab. `#123` means a GitHub issue number of this repository. If `gh` doesn't work,
stop and say so instead of falling back to another tracker.

### Triage labels

The five canonical triage roles map to GitHub labels with the same name (`needs-triage`,
`needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`). See `docs/agents/triage-labels.md`.

### Domain docs

Single-context: one `GLOSSARY.md` and `docs/adr/` at the repo root, created lazily when the first
term or decision is resolved. See `docs/agents/domain.md`.

### Skills

Matt Pocock's skills come from the `mattpocock-skills` Claude Code plugin installed on the
developer's **host** (`claude plugins install mattpocock-skills`, official marketplace), never
vendored here: no `.agents/skills/`, `.claude/commands/` or `skills-lock.json`. Its `ask-matt` skill
maps how the skills connect.
