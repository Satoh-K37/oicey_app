require 'rails_helper'

describe 'Post機能', type: :system do
  describe 'MyPost投稿一覧表示機能' do
    before do
      # ユーザーを作成しておく
      # user_a = FactoryBot.create(:user)
      user_a = FactoryBot.create(:user, oicey_id: 'oicey_test', name: ' ユーザーA', email: 'a@test.com')
      # 作成者がユーザーAである投稿を作成しておく
      FactoryBot.create(:post, body: '最初の投稿', user: user_a)
    end

    context 'ユーザーAがログインしている時' do
      before do
        # ユーザーAでログイン
        visit new_user_session_path
        fill_in 'メールアドレス', with: 'a@test.com'
        fill_in 'パスワード', with: 'password'
        click_button 'LOGIN'
      end

      it 'ユーザーAが作成した投稿一覧が表示される' do
        #作成済みの投稿の内容が画面に表示されていることを確認
        expect(page).to have_content '最初の投稿'
      end
    end

    context 'ユーザーBがログインしている時' do
      before do
        user_a = FactoryBot.create(:user, oicey_id: 'oicey_testB', name: ' ユーザーB', email: 'b@test.com')
        # ユーザーAでログイン
        visit new_user_session_path
        fill_in 'メールアドレス', with: 'b@test.com'
        fill_in 'パスワード', with: 'password'
        click_button 'LOGIN'
      end
    

    end


  end
end
