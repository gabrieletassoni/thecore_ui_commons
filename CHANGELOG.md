# Changelog

## [3.4.0] - 2026-11-24

### Changed
- `omniauth-rails_csrf_protection` may now be `>= 1.0, < 3`. 2.x stops using `ActiveSupport::Configurable` on Rails 8.1, so a Rails 8.1 host boots without its deprecation warning (it goes away in Rails 8.2); on Rails 7.2 it keeps the 1.x code path. Hosts locked on 1.0.x keep working unchanged.
- The dev `Gemfile` runs the suite on Rails 8.1 (`RAILS_VERSION=7.2` for a local 7.2.4 run, best effort) and no longer pins `json < 3.0` (Rails 7.2.4+ no longer passes `quirks_mode:`).

### Added
- Tests for the OmniAuth request phase CSRF check (rejected without a token, accepted with the session's token) and for a boot without the deprecation.
- CI: the gem is published only after the test suite passes on PostgreSQL 15, and each release carries its JUnit report.

## [3.3.7] - 2026-09-08

### Fixed
- Pinned `json < 3.0` in the dev `Gemfile` — json 3.0.1 (released 2026-09-07) turns ActiveSupport's `quirks_mode:` `JSON.generate` option into a hard `ArgumentError` under Rails 7.2, crashing 4 of 5 tests in `test/integration/swagger_test.rb` on every request that committed a session cookie. Test/dev tooling only, does not affect the published gem's runtime behavior.
