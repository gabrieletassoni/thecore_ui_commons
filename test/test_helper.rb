# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require_relative "../test/dummy/config/environment"
# The dummy app has no schema of its own: build the test database from the migrations the engines
# add to the app's db/migrate paths (thecore_auth_commons' users, thecore_settings, ...).
ActiveRecord::Migrator.migrations_paths = Rails.application.paths["db/migrate"].to_a
ActiveRecord::Tasks::DatabaseTasks.migrate
require "rails/test_help"
require_relative "support/junit_report"

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("fixtures", __dir__)
  ActionDispatch::IntegrationTest.fixture_path = ActiveSupport::TestCase.fixture_path
  ActiveSupport::TestCase.file_fixture_path = ActiveSupport::TestCase.fixture_path + "/files"
  ActiveSupport::TestCase.fixtures :all
end
