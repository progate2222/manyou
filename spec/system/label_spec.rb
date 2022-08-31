require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
    let!(:user) { FactoryBot.create(:user) }
    let!(:label) { FactoryBot.create(:label) }

    describe 'タスク登録のテスト' do
        context 'サインアップページから情報を入力し' do
            it "ラベルAが紐づいたタスクを生成できる" do
                visit new_session_path
                fill_in "session_email", with: 'user_general@mail.com'
                fill_in "session_password", with: 'user_general'
                click_on('Log in')
                visit new_task_path
                fill_in "task_name", with: 'task1'
                fill_in "task_detail", with: 'ラベルあり'
                select "2022", from: 'task_deadline_1i'
                select "12", from: 'task_deadline_2i'
                select "31", from: 'task_deadline_3i'
                check 'ラベル'
                click_on('登録する')
                visit tasks_path
                expect(page).to have_content 'ラベルA'
            end
        end
    end

        describe 'ラベル検索のテスト' do
            context 'インデックス画面のラベル検索窓から' do
                it "ラベルAが紐づいたタスクのみ絞り込める" do
                    visit new_session_path
                    fill_in "session_email", with: 'user_general@mail.com'
                    fill_in "session_password", with: 'user_general'
                    click_on('Log in')
                    visit new_task_path
                    fill_in "task_name", with: 'task1'
                    fill_in "task_detail", with: 'ラベルあり'
                    select "2022", from: 'task_deadline_1i'
                    select "12", from: 'task_deadline_2i'
                    select "31", from: 'task_deadline_3i'
                    check 'ラベル'
                    click_on('登録する')
                    visit new_task_path
                    fill_in "task_name", with: 'task2'
                    fill_in "task_detail", with: 'ラベルなし'
                    select "2022", from: 'task_deadline_1i'
                    select "12", from: 'task_deadline_2i'
                    select "31", from: 'task_deadline_3i'
                    click_on('登録する')
                    visit tasks_path
                    select "ラベルA", from: 'label_id'
                    click_on('検索')
                    expect(page).not_to have_content 'ラベルなし'
                end
                end
            end

end
