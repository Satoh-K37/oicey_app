class Entry < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id', dependent: :destroy
  belongs_to :room, foreign_key: 'user_id' , dependent: :destroy

  # ユーザーの情報とルームはレコードごとにかぶる事がないように一意制約をかける。
  validates :room_id, uniqueness: { scope: :user_id }
end
