class Post < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :users, through: :likes
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  ##### タグ機能 #####
  # acts_as_taggable
  acts_as_ordered_taggable_on :tags
  acts_as_taggable_on :skills, :interests

  ##### バリデーション #####
  # 現状は本文を必須にしてるけど、画像投稿機能を実装したら画像か本文のどちらかが投稿されてればOKって感じにしたい
  validates :body, presence: true ,length:  { maximum: 1000 }
  #######################

  # いいねされているか確認する条件式で使う。
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  # いいね通知作成
  def create_notification_like!(current_user)
    # すでに「いいね」されているか検索
    liked = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
    # いいねされていない場合のみ、通知レコードを作成
    if liked.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'like'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  # コメント通知作成
  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    commentd_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    commentd_ids.each do |commentd_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  # 複数通知、自分自身へのコメントの通知を通知済みにする
  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end


end
