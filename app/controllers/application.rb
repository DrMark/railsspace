# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  include ApplicationHelper

  before_filter :check_authorization

  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_rails_space_session_id'

  def check_authorization
    authorization_token = cookies[:authorization_token]
    if authorization_token and not logged_in?
      user = User.find_by_authorization_token(authorization_token)
      user.login!(session) if user
    end
  end
end