class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar])
  end
  
  #Helperをinclide
  include SessionsHelper
  
  #ここからprivateメソッド
  private
  
  def require_user_logged_in
    #ログインユーザーではない場合login画面へと飛ばす
    unless logged_in?
      redirect_to login_url
    end
  end
  
  #カウントするメソッド
  def counts(user)
    @count_posts = user.posts.count
    @count_followings = user.followings.count
    @count_followers = user.followers.count
    @count_favorites = user.favorites.count
  end
  
  
end
