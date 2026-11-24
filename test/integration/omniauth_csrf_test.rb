require "test_helper"
require "open3"

# OmniAuth's request phase (POST /auth/:provider) is CSRF-protected by
# omniauth-rails_csrf_protection, which this gem requires. Its verifier must keep rejecting a
# request without a valid authenticity token on every Rails line the gem supports (7.2 and 8.1),
# and must load without Rails deprecations (ActiveSupport::Configurable goes away in Rails 8.2).
class OmniauthCsrfTest < ActiveSupport::TestCase
  setup do
    @forgery_protection = ActionController::Base.allow_forgery_protection
    ActionController::Base.allow_forgery_protection = true
  end

  teardown do
    ActionController::Base.allow_forgery_protection = @forgery_protection
  end

  # On Rails 8.1, 2.x includes RequestForgeryProtection against ActionController::Base.config itself,
  # which resets these defaults at require time: the app's settings (load_defaults) must still win.
  test "the app's CSRF settings survive loading the verifier" do
    assert ActionController::Base.per_form_csrf_tokens
    assert ActionController::Base.forgery_protection_origin_check
  end

  test "a POST to the request phase without an authenticity token is rejected" do
    env = rack_env_with_session

    assert_raises(ActionController::InvalidAuthenticityToken) do
      OmniAuth.config.request_validation_phase.call(env)
    end
  end

  test "a POST to the request phase with the session's authenticity token is accepted" do
    token = SecureRandom.urlsafe_base64(ActionController::RequestForgeryProtection::AUTHENTICITY_TOKEN_LENGTH)
    env = rack_env_with_session({ _csrf_token: token }, "authenticity_token" => token)

    assert_nothing_raised { OmniAuth.config.request_validation_phase.call(env) }
  end

  # A boot in a separate process: the deprecation is printed once, when the verifier is loaded.
  test "the app boots without the ActiveSupport::Configurable deprecation" do
    dummy = File.expand_path("../dummy", __dir__)
    env = { "RAILS_ENV" => "test", "JUNIT_REPORT_DIR" => nil }
    output, status = Open3.capture2e(env, "bin/rails", "runner", "puts :booted", chdir: dummy)

    assert status.success?, output
    assert_no_match(/ActiveSupport::Configurable is deprecated/, output)
  end

  private

  def rack_env_with_session(session = {}, params = {})
    Rack::MockRequest.env_for(
      "/auth/developer",
      method: "POST",
      params: params,
      "rack.session" => session,
      "rack.session.options" => {}
    )
  end
end
