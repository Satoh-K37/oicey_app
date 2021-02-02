class CommentsController < ApplicationController
  before_action :set_post

  def create
    @comment = @post.comments.new(comment_params)
    if @comment.save
      # redirect_to post_path(@post)
      redirect_back fallback_location: @post, notice: "コメントを送信しました"
    else
      # redirect_to post_path(@post)
      redirect_back fallback_location: @post, notice: "コメントを送信できませんでした。空欄または200文字以上のコメントは送信できません"
    end
  end

  def destroy
    @comment = Comment.find_by(user_id: current_user.id, post_id: params[:post_id])
    if @comment.destroy
      redirect_back fallback_location: @post, notice: "コメントを削除しました"
    else
      redirect_back fallback_location: @post, notice: "コメントの削除に失敗しました"
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end


  def comment_params
    params.require(:comment).permit(:comment).merge(user_id: current_user.id, post_id: params[:post_id])
  end

end
