class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :
  
  #==============ユーザーがフォローしているユーザーとのアソシエーション================
  # Userが中間テーブルの外部キーuser_idにアクセスすることを可能にするアソシエーションを宣言している
  has_many :relationships, foreign_key: "user_id", 
                                    dependent: :destroy
  # Userが中間テーブルfollow_idを通して、followingモデルにアクセスすることを可能にするアソシエーションを宣言している
  has_many :followings, through: :relationships, source: :follow
#============================================================================
#==============ユーザーをフォローしてくれてるユーザーとのアソシエーション==============
  # 架空モデルpassive_relationshipsの外部キーfollow_idへアクセスすることを可能にするアソシエーションを宣言している
  # class_name: "Relationship",で参照元のモデルを指定している
  has_many :passive_relationships, class_name: "Relationship",
                                    foreign_key: "follow_id",
                                    dependent: :destroy
  # Userがpassive_relationshipsのuser_idを通してfollowersへアクセスする事を可能にするアソシエーションの宣言をしている
  has_many :followers, through: :passive_relationships, source: :user
#===========================================================================

  devise :database_authenticatable, :registerable,
        # :confirmable,(登録時に確認用のメールを送ってくれるが今のところ邪魔なのでコメントアウト)
        :recoverable, :rememberable, :trackable, :validatable
        # パスワードを暗号化, ユーザー登録, メール認証
        # PWリセット, ログインしたままにする, サインイン回数, バリデーション
        # プロフィール検索時に使うので必須
  
#==============バリデーション関連==============
  validates :oicey_id, presence: true
  # 名前がないと不便なので必須かつ30文字以内
  validates :name, presence: true, length:  { maximum: 30 }
  # 空欄でもOKだけど、200文字まで
  validates :self_introduction, length: { maximum: 200}
#===========================================================================
  
#==============マッチング関連のインスタンスメソッドを定義==============
  # Userが@userのことをマッチングしているかどうかを確かめる。マッチングボタンを表示する時の条件分岐で使う。
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
#===========================================================================


end
