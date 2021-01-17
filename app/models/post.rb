class Post < ApplicationRecord
  belongs_to :user
  
  # 現状は本文を必須にしてるけど、画像投稿機能を実装したら画像か本文のどちらかが投稿されてればOKって感じにしたい
  validates :body, presence: true ,length:  { maximum: 500 }
  
end
