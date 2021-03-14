class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # ひとりが一つの投稿に対して複数のいいねをつけられないようにする
  validates_uniqueness_of :post_id, scope: :user_id
end
