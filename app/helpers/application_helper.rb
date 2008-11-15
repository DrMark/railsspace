module ApplicationHelper

  # Return a link for use in layout navigation.
  def nav_link(text, controller, action="index")
    link_to_unless_current text, :controller => controller,
                                        :action => action
  end

  # Return true if some user is logged in, false otherwise.
  def logged_in?
    not session[:user_id].nil?
  end
end