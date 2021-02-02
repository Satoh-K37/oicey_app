class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    if @comment.save
      # flash[:success] = "コメントしました"
      redirect_to post_path(@post), notice: "コメントを送信しました"
    else
      # flash[:success] = "コメントできませんでした"
      redirect_to post_path(@post), notice: "コメントを送信できませんでした。空欄または200文字以上のコメントは送信できません"
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:comment).merge(user_id: current_user.id, post_id: params[:post_id])
    end

  # def create
  #   post = Post.find(:post_id)
  #   @comment = current_user.comments.build(post_id: params[:post_id])
  #   if @comment.save
  #     redirect_to post_path(@post)
  #     # redirect_to post_path(params[:post_id])
  #   else
  #     render :show, notice: ' コメントを入力してください'
  # end

  # def destroy
  #   @comment = Comment.find_by(post_id: params[:post_id], user_id: current_user.id)
  #   @comment.destroy
  #   # redirect_to post_path(params[:post_id])
  # end

  # private
  # def comment_params
  #   params.require(:comment).permit(:comment).merge(user_id: current_user.id, post_id: params[:post_id])
  # end

end
