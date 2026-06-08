require "test_helper"

class ThecoreUiCommonsTest < ActiveSupport::TestCase
  test "it has a version number" do
    assert ThecoreUiCommons::VERSION
  end

  test "Version Discovery extracts vN identifiers from routes matching api/vN/info/swagger" do
    fake_path = Struct.new(:spec) { def to_s = spec }
    fake_route = Struct.new(:path)

    routes = [
      fake_route.new(fake_path.new("/api/v2/info/swagger(.:format)")),
      fake_route.new(fake_path.new("/api/v3/info/swagger(.:format)")),
      fake_route.new(fake_path.new("/api/v2/users(.:format)")),
      fake_route.new(fake_path.new("/info/swagger/v2(.:format)")),
    ]

    assert_equal ["v2", "v3"], ThecoreUiCommons.scan_swagger_routes(routes)
  end

  test "Version Discovery sorts versions numerically not lexicographically" do
    fake_path = Struct.new(:spec) { def to_s = spec }
    fake_route = Struct.new(:path)

    routes = [
      fake_route.new(fake_path.new("/api/v10/info/swagger(.:format)")),
      fake_route.new(fake_path.new("/api/v2/info/swagger(.:format)")),
      fake_route.new(fake_path.new("/api/v9/info/swagger(.:format)")),
    ]

    assert_equal ["v2", "v9", "v10"], ThecoreUiCommons.scan_swagger_routes(routes)
  end
end
