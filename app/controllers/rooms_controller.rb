class RoomsController < ApplicationController
  # applicationcontrollerに書いてたきがするから多分必要ない説ある
  before_action :authenticate_user!

  def index
    # 参加中のDMルームを表示するために必要
    # @rooms = current_user.rooms.includes(:messages).order("messages.created_at desc")

    # @room = Room.find(params[:room_id])
    # @rooms = current_user.rooms
    

    # @currentEntriesにログインしているユーザー（自分）Entryテーブルの情報を引っ張ってきて格納
    @currentEntries = current_user.entries
    # 配列myRoomIdsを空の状態で作成
    myRoomIds = []
    
    # each文を使って@currentEntriesに格納したEntryテーブルからRoomテーブルにアクセスし、room.idをmyRoomIdsに格納する
    @currentEntries.each do |entry|
      myRoomIds << entry.room_id
    end
  
    # 自分のuser_idと一致しないユーザーを抽出
    @anotherEntries = Entry.where(room_id: myRoomIds).where.not(user_id: current_user.id)

  end

  def create
      @room = Room.create
      # Entriesテーブルにログイン中のユーザーのIDとルームIDの情報を入れる
      @joinCurrentUser = Entry.create(user_id: current_user.id, room_id: @room.id)
      if @joinCurrentUser.present?
      # ルームに参加するユーザーの情報を入れる
        @joinUser = Entry.create(join_room_params)
      else
        flash[:alert] = "メッセージ送信に失敗しました。"
      end
      # はじめの一言を自動的に入れている。（ここいらんかもな）
      # @first_message = @room.messages.create(user_id: current_user.id, message: "初めまして！")
      # 入ったルームに戻る
      redirect_to room_path(@room.id)
      # redirect_to "/rooms/#{@room.id}"
  end

  def show
    @room = Room.find(params[:id])
    # Entriesテーブルに情報があるか確認
    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
        # ルームが存在している場合は全てのメッセージを取得し、@messagesに格納
        @messages = @room.messages.includes(:user).order("created_at asc")
        # 新規メッセージを作成できるように定義
        @message = Message.new
        # ルームに参加しているユーザーを取得
        @entries = @room.entries
    else
        # 前のページに戻る
        redirect_back(fallback_location: root_path)
    end
  end

  private
  # ルームに参加するユーザーの情報
  def join_room_params
      params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id)
  end

end
