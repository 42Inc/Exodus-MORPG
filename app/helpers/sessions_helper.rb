module SessionsHelper

  def log_in(user)
    session[:user_id] = [user.id, Time.now.to_i]
    if (user.active == false)
      user.update_attribute(:active, true)
    end
    if (user.login_time == nil || user.login_time.to_i != Time.now.to_i)
      user.update_attribute(:login_time, Time.now)
    end
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id[0])
      if (@current_user.active == false)
        session.delete(:user_id)
        @current_user = nil
      else
        log_in @current_user
      end
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
    return @current_user
  end

  def logged_in?
    !current_user.nil?
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    if (current_user.active == true)
      current_user.update_attribute(:active, false)
    end
    @current_user = nil
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
end
