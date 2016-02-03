module SessionsHelper
  # Sätter användarparameterns id i sessionen
  def log_in(user)
    session[:user_id] = user.id
  end

  # Rensar session ur persistent lagring
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Loggar ut en användare helt (session, cookie, @current_user)
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # Hämtar inloggad användare från session eller cookie
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

  # Skapar persistent lagring av en session
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
end
