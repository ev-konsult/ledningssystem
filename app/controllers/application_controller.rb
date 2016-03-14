class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_cache_buster
  include SessionsHelper

  protected
    # Prevents accessing application after log out with back button.
    def set_cache_buster
      response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
      response.headers["Pragma"]        = "no-cache"
      response.headers["Expires"]       = "Fri, 01 Jan 1990 00:00:00 GMT"
    end

    def authorize_login
      redirect_to login_path unless logged_in?
    end
end
