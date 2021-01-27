class RelationshipsController < ApplicationController
  before_action :set_user, only: [:create, :destroy]

  # フォローするアクション
  # Userモデルファイルで定義したfollow(other_user)インスタンスメソッドを使用
  def create
    following = current_user.follow(@user)
    if following.save
      flash[:success] = 'ユーザーをフォローしました'
      redirect_to @user
    else
      flash.now[:alert] = 'ユーザーのフォローに失敗しました'
      redirect_to @user
    end
  end

  # フォロー解除するアクション
  # Userモデルファイルで定義したunfollow(other_user)インスタンスメソッドを使用
  def destroy
    @following = current_user.unfollow(@user)
    if @following.destroy
      flash[:success] = 'ユーザーのフォローを解除しました'
      redirect_to @user
    else
      flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
      redirect_to @user
    end
  end

  private
  def set_user
    # フォロー/フォロー解除ボタンからはparams[:relationship][:follow_id]という形でデータが送られてくるので次の形で受け取る
    @user = User.find(params[:relationship][:follow_id])
  end
end
