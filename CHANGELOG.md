# Changelog

## [3.3.7] - 2026-09-08

### Fixed
- Pinned `json < 3.0` in the dev `Gemfile` — json 3.0.1 (released 2026-09-07) turns ActiveSupport's `quirks_mode:` `JSON.generate` option into a hard `ArgumentError` under Rails 7.2, crashing 4 of 5 tests in `test/integration/swagger_test.rb` on every request that committed a session cookie. Test/dev tooling only, does not affect the published gem's runtime behavior.
