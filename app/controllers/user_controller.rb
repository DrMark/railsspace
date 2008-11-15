class UserController < ApplicationController
  include ApplicationHelper
  before_filter :protect, :only => :index

  def index
    @title = "RailsSpace User Hub"
    # This will be a protected page for viewing user information.
  end

  def register
    @title = "Register"
    if param_posted?(:user)
      @user = User.new(params[:user])
      if @user.save
        @user.login!(session)
        flash[:notice] = "User #{@user.screen_name} created!"
        if (redirect_url = session[:protected_page])
          session[:protected_page] = nil
          redirect_to redirect_url
        else
          redirect_to :action => "index"
        end
      else
        @user.clear_password!
      end
    end
  end

  def login
    @title = "Log in to RailsSpace"
    if param_posted?(:user)
      @user = User.new(params[:user])
      user = User.find_by_screen_name_and_password(@user.screen_name,
                                                   @user.password)
      if user
        user.login!(session)
        flash[:notice] = "User #{user.screen_name} logged in!"
        if (redirect_url = session[:protected_page])
          session[:protected_page] = nil
          redirect_to redirect_url
        else
          redirect_to :action => "index"
        end
      else
        @user.clear_password!
        flash[:notice] = "Invalid screen name/password combination"
      end
    end
  end

  def logout
    User.logout!(session)
    flash[:notice] = "Logged out"
    redirect_to :action => "index", :controller => "site"
  end

  private

  # Protect a page from unauthorized access.
  def protect
    unless logged_in?
      session[:protected_page] = request.request_uri
      flash[:notice] = "Please log in first"
      redirect_to :action => "login"
      return false
    end
  end

  # Return true if a parameter corresponding to the given symbol was posted.
  def param_posted?(symbol)
    request.post? and params[symbol]
  end
end