class PostsController < ApplicationController
  before_action :set_post, only: [:edit,:destroy]

  def index
    # ログインしているユーザーの投稿のみを表示する
    # @posts = current_user.posts.all
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.save!
    redirect_to posts_url, notice: "投稿を送信しました"
  end

  def edit
    # @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post.update!(post_params)
    redirect_to posts_url, notice: "投稿を編集しました"
  end

  def destroy
    # post = Post.find(params[:id])
    post.destroy
    redirect_to posts_url, notice: "投稿を削除しました" 
  end


  private

  def set_post
    @post =  current_user.posts.find(params[:id])
  end


  def post_params
    params.require(:post).permit(:body, :images, :visit_day)
  end

end
