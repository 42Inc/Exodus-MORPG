module SessionsHelper
  $time_to_disconnect = 1800
  # Осуществляет вход данного пользователя.
  def log_in(user)
#    print("\nUpdate session!\n")
    session[:user_id] = [user.id, Time.now.to_i]
  end

  # Возвращает пользователя, соответствующего remember-токену в куки.
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id[0])
      time_diff = Time.now.to_i - user_id[1]
      if (time_diff > $time_to_disconnect)
        session.delete(:user_id)
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

  # Возвращает true, если пользователь вошел, иначе false.
  def logged_in?
    !current_user.nil?
  end

  # Забывает постоянную сессии.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Осуществляет выход текущего пользователя.
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # Запоминает пользователя в постоянную сессию.
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
end
