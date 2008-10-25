class UserController < ApplicationController

  def index
  end

  def register
    @title = "Register"
    if request.post? and params[:user]
      @user = User.new(params[:user])
      if @user.save
        render :text => "User created!"
      end
    end
  end
end