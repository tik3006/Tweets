class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
  #投稿を探す
  post = Post.find(params[:post_id])
  current_user.like(post)
  flash[:success] = 'add favorites'
  redirect_to root_path
  end

  def destroy
  post = Post.find(params[:post_id])
  current_user.unlike(post)
  flash[:danger] = 'Delete your favorite'
  redirect_to root_path
  end
end
