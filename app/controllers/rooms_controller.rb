class RoomsController < ApplicationController
  # applicationcontrollerに書いてたきがするから多分必要ない説ある
  before_action :authenticate_user!

  def index
    # 参加中のDMルームを表示するために必要
      @rooms = current_user.rooms.includes(:messages).order("messages.created_at desc")
  end

  def create
      @room = Room.create
      # Entriesテーブルにログイン中のユーザーのIDとルームIDの情報を入れる
      @joinCurrentUser = Entry.create(user_id: current_user.id, room_id: @room.id)
      # ルームに参加するユーザーの情報を入れる
      @joinUser = Entry.create(join_room_params)
      # はじめの一言を自動的に入れている。（ここいらんかもな）
      @first_message = @room.messages.create(user_id: current_user.id, message: "初めまして！")
      # 入ったルームに戻る
      redirect_to room_path(@room.id)
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
        redirect_back(fallback_location: root_path)
    end
  end

  private
  # ルームに参加するユーザーの情報
  def join_room_params
      params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id)
  end

end
