require "test_helper"

# A locked user (users.locked) on the sign-in form gets exactly the wrong-password answer: same
# status, same words, so the page tells neither that the account exists nor that the password was
# right (host Odoo #6051, #6259). thecore_auth_commons >= 3.7.1 refuses them; this gem must not
# answer before it does (it once signed them out with "Your account is locked.").
class LockedUserSignInTest < ActionDispatch::IntegrationTest
  PASSWORD = "Local-Pass-123!".freeze
  WRONG_PASSWORD_ALERT = "Invalid credentials or password.".freeze

  setup do
    # The last unlocked user can't be locked (User validation): keep another one around.
    User.create!(email: "other@example.com", password: PASSWORD, password_confirmation: PASSWORD)
    @user = User.create!(email: "worker@example.com", password: PASSWORD, password_confirmation: PASSWORD)
  end

  test "a wrong password is refused with 401 and the generic alert" do
    sign_in_with "Wrong-Pass-123!"

    assert_response :unauthorized
    assert_equal WRONG_PASSWORD_ALERT, flash[:alert]
  end

  test "a locked user with the right password gets the wrong-password answer" do
    @user.update!(locked: true)

    sign_in_with PASSWORD

    assert_response :unauthorized
    assert_equal WRONG_PASSWORD_ALERT, flash[:alert]
    assert_no_match(/locked/i, response.body)
  end

  private

  def sign_in_with(password)
    post user_session_path, params: { user: { email: @user.email, password: password } }
  end
end
