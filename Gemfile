source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Specify your gem's dependencies in thecore_ui_commons.gemspec.
gemspec

# The Rails line this suite runs on (host Odoo #6089/#6090, host ADR 0033): Rails 8.1, the only one CI
# tests. Dual support is best effort: the gemspec names no Rails version, its dependencies must keep
# resolving on 7.2 too. `RAILS_VERSION=7.2 bundle update rails && RAILS_VERSION=7.2 bin/test`
# runs it on 7.2.4 locally. minitest stays on 5, since Rails 7.2's test runner breaks on minitest 6.
RAILS_LINE = ENV["RAILS_VERSION"] == "7.2" ? ["~> 7.2.4"] : ["~> 8.1", ">= 8.1.4.1"]
gem "rails", *RAILS_LINE
gem "minitest", "~> 5.25"

gem "pg"
gem "sprockets-rails"

# Start debugger with binding.b [https://github.com/ruby/debug]
# gem "debug", ">= 1.0.0"

# JUnit XML report in CI (test/support/junit_report.rb, only when JUNIT_REPORT_DIR is set).
gem "minitest-reporters", "~> 1.8"
