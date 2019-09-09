module SessionsHelper

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
   #loginしてる場合trueを返す
   if current_user
   return true
  else
    #loginしていない場合falseを返す
    return false
   end
  end
end