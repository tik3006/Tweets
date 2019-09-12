class ApplicationController < ActionController::Base
  
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
