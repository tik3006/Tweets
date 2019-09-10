class ToppagesController < ApplicationController
  def index
    if logged_in?
      #postのインスタンスを生成する
      @post = current_user.posts.build
      @posts = current_user.feed_posts.order(id: :desc).page(params[:page])
    end
  end
end
