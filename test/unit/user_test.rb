require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @valid_user = users(:valid_user)
    @invalid_user = users(:invalid_user)
  end

  # This user should be valid by construction.
  def test_user_validity
    assert users(:valid_user).valid?
  end

  # This user should be invalid by construction.
  def test_user_invalidity
    assert !@invalid_user.valid?
    attributes = [:screen_name, :email, :password]
    attributes.each do |attribute|
      assert @invalid_user.errors.invalid?(attribute)
    end
  end

  # One test that checks the uniqueness of both screen name and email
  def test_uniqueness_of_screen_name_and_email
    user_repeat = User.new(:screen_name => @valid_user.screen_name,
                           :email => @valid_user.email,
                           :password => @valid_user.password)
    assert !user_repeat.valid?
    assert_equal "has already been taken", user_repeat.errors.on(:screen_name)
    assert_equal "has already been taken", user_repeat.errors.on(:email)
  end
end
