require 'test_helper'

class UserControllerTest < ActionController::TestCase

  # Make sure the registration page responds with the proper form.
  def test_registration_page
    get :register
    title = assigns(:title)
    assert_equal "Register", title
    assert_response :success
    assert_template "register"

    # Test the form and all its tags.
    assert_tag "form", :attributes => { :action => "/user/register",
                                        :method => "post" }
    assert_tag   "input",
                :attributes => { :name => "user[screen_name]",
                                 :type => "text",
                                 :size => User::SCREEN_NAME_SIZE,
                                 :maxlength => User::SCREEN_NAME_MAX_LENGTH }
    assert_tag   "input",
                :attributes => { :name => "user[email]",
                                 :type => "text",
                                 :size => User::EMAIL_SIZE,
                                 :maxlength => User::EMAIL_MAX_LENGTH }
    assert_tag   "input",
                :attributes => { :name => "user[password]",
                                 :type => "password",
                                 :size => User::PASSWORD_SIZE,
                                 :maxlength => User::PASSWORD_MAX_LENGTH }
    assert_tag   "input", :attributes => { :type => "submit",
                                          :value => "Register!" }
  end
end
