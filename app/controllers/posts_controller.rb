class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :loged_in_user, only: [:destroy,:show,:edit,:update]
  
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'posted'
      redirect_to root_path
    else
    @posts = current_user.feed_posts.order(id: :desc).page(params[:page])
    flash.now[:danger] = 'faild post'
    render 'toppages/index'
    end 
  end

  def destroy
    #投稿を削除する
    @post.destroy
    flash[:success] = 'Delete Post'
    redirect_back(fallback_location: root_path)
  end
  
 
  def edit
   
  end
  
  
  def update
   if @post.update(post_params)
    flash[:success] = "Your Tweet is Update"
    redirect_to root_path
  else
    flash[:danger] = "Update Faild"
    render edit
   end
  end
  
  
  private
  
  def post_params
    params.require(:post).permit(:content)
  end
  
  
  def loged_in_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
    redirect_to root_url
    end
  end
end