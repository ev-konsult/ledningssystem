module SessionsHelper
  # Sets user id in session, effectively logging in the user
  def log_in(user)
    session[:user_id] = user.id
  end

  # Clear user from cookies
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Clear user from both session and cookies
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # Retrieved logged in user from either session or cookies
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  # Creates persistent login for user (cookies)
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def admin?
    current_user.admin?
  end

  # Sends non-admins to their profile pages
  def check_if_admin
    unless logged_in?
      redirect_to login_path
    else
      unless current_user.admin?
        redirect_to current_user
      end
    end
  end

  def check_if_logged_in
    redirect_to root_path unless logged_in?
  end

end
