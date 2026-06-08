require "test_helper"

class SwaggerTest < ActionDispatch::IntegrationTest
  test "GET /info/swagger redirects to /info/swagger/v2" do
    get "/info/swagger"
    assert_redirected_to "/info/swagger/v2"
  end

  test "GET /info/swagger/v2 returns 200" do
    get "/info/swagger/v2"
    assert_response :success
  end

  test "Version Nav Banner is not rendered when only one API version is available" do
    ThecoreUiCommons.swagger_api_versions = ["v2"]
    get "/info/swagger/v2"
    assert_response :success
    assert_no_match %r{id="version-nav"}, response.body
  ensure
    ThecoreUiCommons.swagger_api_versions = []
  end

  test "Version Nav Banner lists all versions with current highlighted when multiple versions available" do
    ThecoreUiCommons.swagger_api_versions = ["v2", "v3"]
    get "/info/swagger/v2"
    assert_response :success
    assert_match %r{id="version-nav"}, response.body
    assert_match %r{class="current"[^>]*>v2<}, response.body
    assert_match %r{href="[^"]*v3"[^>]*>v3<}, response.body
  ensure
    ThecoreUiCommons.swagger_api_versions = []
  end

  test "version param with invalid chars is stripped before use in Swagger URL" do
    get "/info/swagger/v2%3Cscript%3E"
    assert_response :success
    assert_match %r{/api/v2script/info/swagger\.json}, response.body
    assert_no_match %r{/api/v2<script>/info/swagger}, response.body
  end
end
