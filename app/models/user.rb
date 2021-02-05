class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
        # :confirmable,(登録時に確認用のメールを送ってくれるが今のところ邪魔なのでコメントアウト)
        :recoverable, :rememberable, :trackable, :validatable
        # パスワードを暗号化, ユーザー登録, メール認証
        # PWリセット, ログインしたままにする, サインイン回数, バリデーション
        # プロフィール検索時に使うので必須
  
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  # これでユーザーがいいねした投稿を取得できる
  has_many :like_posts, through: :likes, source: :post
  has_many :comments, dependent: :destroy
  # 自分から相手へ送る通知
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  # 相手から自分へ送られてくる通知
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :

  ########### DM　############
  #　一人のユーザーは複数のエントリー(entries)を行い、複数のルーム(rooms)に入り、複数のメッセージ(messages)を送れるので全部has_manyになる
  has_many :messages
  has_many :entries
  has_many :rooms, through: :entries
  ###########################
  #==============ユーザーがフォローしているユーザーとのアソシエーション================
  has_many :relationships,  foreign_key: "user_id", 
                            dependent: :destroy
  #  フォローしているユーザーの一覧を取り出すときに使う
  has_many :followings, through: :relationships, source: :follow
#============================================================================
#==============ユーザーをフォローしてくれてるユーザーとのアソシエーション==============
  has_many :passive_relationships,  class_name: "Relationship",
                                    foreign_key: "follow_id",
                                    dependent: :destroy
  #  フォローされてるユーザーの一覧を取り出すときに使う
  has_many :followers, through: :passive_relationships, source: :user
#===========================================================================
  
#==============バリデーション関連==============
  #　OiceyIDは英数字15文字までアルファベットと数字以外は弾くようにしたい。（＊％＄＃＠＾！？とか）(英字、数字、「_」が利用できる。スペースはつかない　) 
  validates :oicey_id, presence: true, length:  { maximum: 15 }
  # 名前がないと不便なので必須かつ50文字以内
  validates :name, presence: true, length:  { maximum: 50 }
  # 空欄でもOKだけど、200文字まで
  validates :self_introduction, length: { maximum: 200}
#===========================================================================
  
#==============マッチング関連のインスタンスメソッドを定義==============
  # Userが@userのことをフォローしているかどうかを確かめる。マッチングボタンを表示する時の条件分岐で使う。
  def following?(other_user)
    self.followings.include?(other_user)
  end

  # フォローするメソッド
  def follow(other_user)
    # 自分自身をフォローできないようにする
    unless self == other_user
      # @userのidが存在する場合はそれを参照し、存在しない場合は
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  # フォロー解除するメソッド
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  # マッチング判定
  def matchers
    # それぞれのメソッドを実行し、フォローしている&&フォローされているユーザーを確認する
    followings & followers
  end

  # フォロー通知作成
  # 通知レコード作成
  def create_notification_follow!(current_user)
    notification_record = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if notification_record.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

#===========================================================================

end
