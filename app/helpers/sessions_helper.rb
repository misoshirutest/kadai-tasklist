module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
    # if else の短縮形
  end

  def logged_in?
    !!current_user
    # トリック。ログインしていればtrue、していなければfalseを返す
  end

end
