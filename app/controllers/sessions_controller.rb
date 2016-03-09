class SessionsController < ApplicationController
  # Authenticates user, if user exists
  # Remembers session if :remember_me is passed as param
  def create
    user = User.find_by(user_name: params[:session][:user_name])
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to user
    else
      flash.now[:danger] = 'Felaktig inloggingsinformation!'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  # Makes sure that application doesn't root to login,
  # if you're already logged in
  def new
    if logged_in?
      redirect_to current_user
    end
  end
end
