require 'test_helper'

class UserControllerTest < ActionController::TestCase

  # Make sure the registration page responds with the proper form.
  def test_registration_page
    get :register
    title = assigns(:title)
    assert_equal "Register", title
    assert_response :success
    assert_template "register"
  end
end
