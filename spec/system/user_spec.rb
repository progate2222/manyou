require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
    let!(:user) { FactoryBot.create(:user) }
    let!(:admin_user) {  FactoryBot.create(:admin_user) }
    let!(:admin_user2) {  FactoryBot.create(:admin_user, email:'user_admin2@mail.com' ) }
    let!(:user2) { FactoryBot.create(:user, email:'user2@mail.com' ) }
    let!(:user3 ) { FactoryBot.create(:user, email:'user3@mail.com') }

    describe 'ユーザ登録のテスト' do
        context 'サインアップページから情報を入力し' do
            it 'ユーザの新規登録ができる' do
                visit new_user_path
                fill_in "user_name", with: 'user'
                fill_in "user_email", with: 'user@mail.com'
                fill_in "user_password", with: 'password'
                fill_in "user_password_confirmation", with: 'password'
                click_on('Create my account')
                expect(page).to have_content 'userのページ'
            end
        end

        context 'ユーザがログインせずタスク一覧画面に飛ぼうとしたとき' do
            it 'ログイン画面に遷移する' do
                visit new_user_path
                visit tasks_path
                expect(page).to have_content 'Sign up'
            end
        end
    end

    describe 'セッション機能のテスト' do
        before do
            visit new_session_path
            fill_in "session_email", with: 'user_general@mail.com'
            fill_in "session_password", with: 'user_general'
            click_on('Log in')
        end

        context 'ログインページから情報を入力し' do
            it 'ログインができる' do
                expect(page).to have_content 'user_generalのページ'
            end
        end

        context 'ユーザがログインした後に' do
            it '自分の詳細画面(マイページ)に飛べる' do
                visit tasks_path
                click_link('マイページ')
                expect(page).to have_content 'user_generalのページ'
            end
        end

        context '一般ユーザが他人の詳細画面に飛ぶと' do
            it 'タスク一覧画面に遷移する' do
                visit new_session_path
                fill_in "session_email", with: 'user_general@mail.com'
                fill_in "session_password", with: 'user_general'
                click_on('Log in')
                visit user_path(admin_user)
                expect(page).to have_content 'generalタスク一覧'
            end
        end

        context 'ユーザがログインした後に' do
            it 'ログアウトができる' do
                click_link('Logout')
                expect(page).to have_content 'ログアウトしました'
            end
        end
    end

    describe '管理画面のテスト' do
        before do
            visit new_session_path
            fill_in "session_email", with: 'user_admin@mail.com'
            fill_in "session_password", with: 'user_admin'
            click_on('Log in')
            click_link('管理者ページ')
            click_on('ユーザー登録')
            fill_in "user_name", with: 'user'
            fill_in "user_email", with: 'user@mail.com'
            fill_in "user_password", with: 'password'
            fill_in "user_password_confirmation", with: 'password'
            select "false", from: 'user_admin'
            click_on('登録')
        end

        context '管理ユーザは' do
            it '管理画面にアクセスできる' do
                click_link('管理者ページ')
                expect(page).to have_content '管理画面のユーザー一覧'
            end

            it 'ユーザの新規登録ができる' do
                expect(page).to have_content 'ユーザー【user】の詳細'
            end

            it 'ユーザの詳細画面にアクセスできる' do
                expect(page).to have_content 'ユーザー【user】の詳細'
            end

            it 'ユーザの編集画面からユーザを編集できる' do
                click_link('編集する')
                fill_in "user_name", with: 'edit_user'
                fill_in "user_email", with: 'user1@mail.com'
                fill_in "user_password", with: 'password1'
                fill_in "user_password_confirmation", with: 'password1'
                select "false", from: 'user_admin'
                click_on('編集')
                expect(page).to have_content 'ユーザーの更新に成功しました'
            end

            it 'ユーザの削除ができる' do
                click_link('削除する')
                expect(page).to have_content '削除が完了しました'
            end
        end

        context '一般ユーザは' do
            it '管理画面にアクセスできない' do
                click_link('Logout')
                visit new_session_path
                fill_in "session_email", with: 'user_general@mail.com'
                fill_in "session_password", with: 'user_general'
                click_on('Log in')
                visit tasks_path
                click_link('管理者ページ')
                expect(page).to have_content 'generalタスク一覧'
            end
        end
    end

end
