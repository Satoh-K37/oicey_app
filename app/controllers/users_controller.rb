class UsersController < ApplicationController

  def show
    # プロフィール情報
    # @user = current_user
    # フォローボタン
    @user = User.find(params[:id])
    # 
    @relationship = current_user.relationships.find_by(follow_id: @user.id)  
    @set_relationship = current_user.relationships.new
    # 自身の投稿一覧
    @myposts = current_user.posts.all
    # ユーザーがいいねした投稿を取得
    @like_posts = @user.like_posts
    @rooms = @user.rooms

    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |currentUser|
        @userEntry.each do |entryUser|
          if currentUser.room_id == entryUser.room_id then
            @isRoom = true
            @roomId = currentUser.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
    # DM
    # サイン済みかを判断
    # if user_signed_in?
    #   # current_userが既にルームに参加してるかを調べる
    #   @currentUserEntry = Entry.where(user_id: current_user.id)
    #   # 
    #   @userEntry = Entry.where(user_id: @user.id)
    #   unless @user.id == current_user.id
    #     @currentUserEntry.each do |currentUser|
    #       @userEntry.each do |entryUser|
    #         if currentUser.room_id == entryUser.room_id
    #           # 既にルームがあるという意味の変数
    #           @haveRoom = true
    #           # ルームにアクセスするための変数
    #           @roomId = currentUser.room_id
    #         end
    #       end
    #     end

    #     unless @haveRoom
    #       # 部屋がない場合にここの処理が実行
    #       @room = Room.new
    #       @entry = Entry.new
    #     end
    #   end
    # end
    

  end

  # フォローしている人を取得（フォロー）。気になるした人っていう使い方もできそう。
  def followings
    @user = User.find(params[:id])
    @users = @user.followings.all
  end

  # フォローしてくれている人を取得（フォロワー）。気になるされた人っていう使い方もできそう
  def followers
    @user = User.find(params[:id])
    @users = @user.followers.all
  end

  # マッチングしているユーザーを取得する
  def matchings
    # user.rbのmatchersをcurrent_userでログインしているユーザーがフォローしている、フォローされているユーザーを取得し、match_usersに格納している
    @match_users = current_user.matchers
  end

  def edit
    # super
    @user = current_user
  end

  # # PUT /resource
  def update
    # super
    # 対象のユーザーをidで検索して、@userに格納
    @user = User.find(params[:id])
    #　user_paramsの値に変更があった場合にifの処理に入る。それ以外はelseに入る。
    if @user.update(user_params)
      # 更新に成功したら、ユーザー詳細ページに遷移する
      redirect_to profile_user_path(current_user), notice: '更新しました'
    else
      # 更新に失敗した場合は再度、編集のページを表示させる
      render :profile_edit
    end
  end
  
  def destroy
    # セッションに保存された情報を削除
    reset_session
    # Welcomeページに遷移
    # とりあえず新規登録ページに遷移するようにしてる。Welcomeページが完成したらそっちに遷移させる
    redirect_to sign_in_path, notice: 'ログアウトしました'
  end

  private

  def user_params
    params.require(:user).permit(:name, :self_introduction)
  end

end
