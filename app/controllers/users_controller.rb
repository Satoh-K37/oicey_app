class UsersController < ApplicationController
  def show
    @user = current_user
  end

  # def edit
  #   # super
  #   @user = current_user
  # end

  # # # PUT /resource
  # def update
  #   # super
  #       # 対象のユーザーをidで検索して、@userに格納
  #   # 共通化済み　set_user
  #   #　user_paramsの値に変更があった場合にifの処理に入る。それ以外はelseに入る。
  #   if @user.update(user_params)
  #     # 更新に成功したら、ユーザー詳細ページに遷移する
  #     redirect_to profile_path(current_user), notice: '更新しました'
  #   else
  #     # 更新に失敗した場合は再度、編集のページを表示させる
  #     render :profile_edit
  #   end
  # end

  # private

  # def user_params
  #   params.require(:user).permit(:name, :self_introduction)
  # end

end