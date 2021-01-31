class LikesController < ApplicationController
  def create
    # like.user_id = current_user.idが済んだ状態で生成される。bulidはnewと同じ意味。アソシエーションしながらインスタンスをnewするときに使われるらしい。
    like = current_user.likes.build(post_id: params[:post_id])
    like.save
    redirect_to posts_path
  end

  def destroy
    like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
    like.destroy
    redirect_to posts_path

  end

end
