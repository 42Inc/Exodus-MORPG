module SessionsHelper
  $time_to_disconnect = 1800

  def log_in(user)
    session[:user_id] = [user.id, Time.now.to_i]
    if (user.active == false)
      user.update_attributes(active: true)
    end
  end


  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id[0])
      time_diff = Time.now.to_i - user_id[1]
      if (time_diff > $time_to_disconnect)
        session.delete(:user_id)
        if (user.active == true)
          current_user.update_attributes(active: false)
        end
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
