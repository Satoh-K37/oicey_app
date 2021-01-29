class Relationship < ApplicationRecord
  belongs_to :user
  # Userモデルを参照する架空モデル
  belongs_to :follow, class_name: "User"

  validates :user_id, presence: true
  validates :follow_id, presence: true
end
