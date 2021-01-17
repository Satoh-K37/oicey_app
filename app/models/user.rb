class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        # :confirmable,(登録時に確認用のメールを送ってくれるが今のところ邪魔なのでコメントアウト)
         :recoverable, :rememberable, :trackable, :validatable
        # パスワードを暗号化, ユーザー登録, メール認証
        # PWリセット, ログインしたままにする, サインイン回数, バリデーション
  # プロフィール検索時に使うので必須
  validates :oicey_id, presence: true
  # 名前がないと不便なので必須かつ30文字以内
  validates :name, presence: true, length:  { maximum: 30 }
  # 空欄でもOKだけど、200文字まで
  validates :self_introduction, length: { maximum: 200}
  

end
