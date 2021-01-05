class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.save!
    redirect_to posts_url, notice: "投稿を送信しました"
  end


  def edit
  end

  private

  def post_params
    params.require(:post).permit(:body, :images, :visit_day)
  end

end
