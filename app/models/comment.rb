class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  # , optional: true
  has_many :notifications, dependent: :destroy

  #### バリデーション #####
  validates :comment, presence: true ,length:  { maximum: 200 }

end
