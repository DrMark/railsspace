class SiteController < ApplicationController
  def index
    @title = "RailsSpace"
  end

  def about
    @title = "About RailsSpace"
  end

  def help
    @title = "RailsSpace Help"
  end
end
