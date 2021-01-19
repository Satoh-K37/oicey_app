class Post < ApplicationRecord
  belongs_to :user
  ##### タグ機能 #####
  acts_as_taggable
  acts_as_taggable_on :skills, :interests
  #######################

  ##### バリデーション #####
  # 現状は本文を必須にしてるけど、画像投稿機能を実装したら画像か本文のどちらかが投稿されてればOKって感じにしたい
  validates :body, presence: true ,length:  { maximum: 500 }
  #######################
end
