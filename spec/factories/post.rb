FactoryBot.define do
  # factory :admin_user, class: User do ファクトリ名とクラスが異なる時はこれでいける。
  factory :post do
    body { 'テスト外食行ってきた！Rspecを用意した！' }
    #画像投稿機能は実装してないのでテストしない
    # images { 'test.' }
    # 日付も必須ではないのでテストしない
    # visit_day
  end
end
