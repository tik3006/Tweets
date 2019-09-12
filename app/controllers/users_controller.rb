class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  
 
  def index
   #全ユーザー表示
    @users = User.order(id: :desc).page(params[:page]).per(10)
  end

 
  #ユーザー情報
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(id: :desc).page(params[:page])
    counts(@user)
  end

 
 #ユーザーの作成
  def new
    @user = User.new
  end

 
 #ユーザーの登録
  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'User Successfull Registration'
      redirect_to @user
    else
      flash.now[:danger] = 'User registration Failed'
      render :new
    end
  end

 
 
 #ユーザー情報編集
  def edit
    @user = User.find(params[:id])
  end
  
  
  #編集の適用
  def update
   @user = User.find(params[:id])
   if @user.update(user_params)
    flash[:success] = "Your Profile is Update"
    redirect_to root_path
  else
    flash[:danger] = "Failed Update" 
    render :edit
   end
  end

  #ユーザー退会
  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:success] = "See you"
    redirect_to root_path
  end  
 
  def followings
    @user = User.find(params[:id])
    @followings = @user.followers.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
   #お気に入り投稿一覧取得
  def likes
    @user = User.find(params[:id])
    @favorites = @user.favorite_post.order(id: :desc).page(params[:page])
    counts(@user)
  end
  
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
