class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,:confirmable,
         :recoverable, :rememberable, :trackable, :validatable
        # パスワードを暗号化, ユーザー登録, メール認証
        # PWリセット, ログインしたままにする, サインイン回数, バリデーション
end
