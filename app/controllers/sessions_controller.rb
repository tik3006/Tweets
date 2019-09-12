class SessionsController < ApplicationController
  
  def new
  end

  def create
    #sessionとemailを取得する
    email = params[:session][:email].downcase
    #passwordを取得する
    password = params[:session][:password]
    
    #login判定を行う
    if login(email, password)
      flash[:success] = 'Log in'
      redirect_to @user
    else
      flash.now[:danger] = 'Login Failed'
      render 'new'
    end
  end
  
  def destroy
    #sessionにnilを代入する
    session[:user_id] = nil
    flash[:success] = 'logout'
    redirect_to root_url
  end
  
  
  #ここからprivateメソッド
  private

  def login(email, password)
    
    @user = User.find_by(email: email)
    
    #userの存在とpasswordがあっている確認する
    if @user && @user.authenticate(password)
      
      # ログイン成功の場合sessionに格納する
      session[:user_id] = @user.id
      return true
    else
      # ログイン失敗
      return false
    end
  end
end