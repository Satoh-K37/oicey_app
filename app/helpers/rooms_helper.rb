module RoomsHelper
    # 最新メッセージのデータを取得して表示するメソッド
    def most_new_message_preview(room)
      # 最新メッセージのデータを取得する
      message = room.messages.order(updated_at: :desc).limit(1)
      # 配列から取り出す
      message = message[0]
      # メッセージの有無を判定
      if message.present?
        # メッセージがあれば内容を表示
        tag.p "#{message.message}", class: "dm_list__content__link__box__message"
      else
        # メッセージがなければ[ まだメッセージはありません ]を表示
        tag.p "まだメッセージはありません", class: "dm_list__content__link__box__message"
      end
    end
  
    # 相手ユーザー名を取得して表示するメソッド
    def opponent_user(room)

      # 中間テーブルから相手ユーザーのデータを取得
      entry = room.entries.where.not(user_id: current_user)
      # 中間テーブルEntryからcurrent_userのIDじゃないIDを検索して、インスタンス変数entryに格納する
      # ログインしているユーザー本人の奴が取得されてるっぽい？って思ったけど、別のユーザーでもOicey娘が表示されてるし、わけわからん…


      # @entry = room.entries.where.not(id: user.id)
      # 相手ユーザーの名前を取得
      name = entry[0].user.name
      # 名前を表示
      tag.p "#{name}", class: "dm_list__content__link__box__name"
    end
end
