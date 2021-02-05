class Entry < ApplicationRecord
  belongs_to :user
  belongs_to :room

  # ユーザーの情報とルームはレコードごとにかぶる事がないように一意制約をかける。
  validates :room_id, uniqueness: { scope: :user_id }
end
