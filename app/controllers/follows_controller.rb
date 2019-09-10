class FollowsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    user = User.find(params[:follow_id])
    current_user.following(user)
    flash[:success] = 'follow user'
    redirect_to user
  end

  def destroy
    user = User.find(params[:follow_id])
    current_user.unfollow(user)
    flash[:success] = 'Unfollow user'
    redirect_to user
  end
end
