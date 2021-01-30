class Post < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :users, through: :likes
  ##### タグ機能 #####
  # acts_as_taggable
  acts_as_ordered_taggable_on :tags
  acts_as_taggable_on :skills, :interests

  ##### バリデーション #####
  # 現状は本文を必須にしてるけど、画像投稿機能を実装したら画像か本文のどちらかが投稿されてればOKって感じにしたい
  validates :body, presence: true ,length:  { maximum: 500 }
  #######################

  # いいねされているか確認する条件式で使う。
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

end
