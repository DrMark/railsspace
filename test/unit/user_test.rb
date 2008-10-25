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
end
