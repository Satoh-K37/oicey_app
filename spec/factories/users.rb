FactoryBot.define do
  # factory :admin_user, class: User do ファクトリ名とクラスが異なる時はこれでいける。
  factory :user do
    #nに連番の数字が入る
    # name { 'テストユーザ' }
    sequence(:name) { |n| "テストユーザ#{n}" }
    # sequence(:user_name) { |n|'テストユーザー#{n}' }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end