require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:task1) { FactoryBot.create(:task, name: 'task1', detail:'task1_detail', deadline: '2022-10-31', user: user) }

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      before do
        visit new_session_path
        fill_in "session_email", with: 'user_general@mail.com'
        fill_in "session_password", with: 'user_general'
        click_on('Log in')
        visit tasks_path
      end
      it '該当タスクの内容が表示される' do
        visit tasks_path
        click_link('詳細')
        expect(page).to have_content 'task1'
      end
    end
  end

  describe '新規作成機能' do
    before do
      visit new_session_path
      fill_in "session_email", with: 'user_general@mail.com'
      fill_in "session_password", with: 'user_general'
      click_on('Log in')
      visit tasks_path
    end
    context 'タスクを新規登録するとき' do
      it '終了期限も登録できる' do
        visit new_task_path
        fill_in "task_name", with: 'task2'
        fill_in "task_detail", with: 'task2_detail'
        select "2022", from: 'task_deadline_1i'
        select "12", from: 'task_deadline_2i'
        select "31", from: 'task_deadline_3i'
        click_on('登録する')
        expect(page).to have_content '2022-12-31'
      end
      it 'ステータスも登録ができる' do
        visit new_task_path
        fill_in "task_name", with: 'task2'
        fill_in "task_detail", with: 'task2_detail'
        select "着手中", from: 'task_status'
        click_on('登録する')
        expect(page).to have_content '着手中'
      end
    end
  end

  describe '一覧表示機能' do
    before do
      visit new_session_path
      fill_in "session_email", with: 'user_general@mail.com'
      fill_in "session_password", with: 'user_general'
      click_on('Log in')
      visit tasks_path
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
        expect(page).to have_content 'task1'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        visit new_task_path
        fill_in "task_name", with: 'task2'
        fill_in "task_detail", with: 'task2_detail'
        click_on('登録する')
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'task2'
        expect(task_list[1]).to have_content 'task1'
      end
    end
    context '終了期限でソートするというリンクを押すと' do
      it '終了期限の降順に並び替えられたタスク一覧が表示される' do
        visit new_task_path
        fill_in "task_name", with: 'task2'
        fill_in "task_detail", with: 'task2_detail'
        select "2022", from: 'task_deadline_1i'
        select "12", from: 'task_deadline_2i'
        select "31", from: 'task_deadline_3i'
        click_on('登録する')
        visit tasks_path
        click_on('終了期限でソートする')
        task_list = all('.task_row')
        expect(find_by_id('task_0')).to have_content 'task2'
        expect(find_by_id('task_1')).to have_content 'task1'
      end
    end
  end

  describe '検索機能' do
  let!(:task2) {FactoryBot.create(:task, name: "walking", user: user)}
  let!(:task3) {FactoryBot.create(:task, name: "shopping", user: user)}
  let!(:task4) {FactoryBot.create(:second_task, name: "play_sports", user: user)}

    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit new_session_path
        fill_in "session_email", with: 'user_general@mail.com'
        fill_in "session_password", with: 'user_general'
        click_on('Log in')
        visit tasks_path
        fill_in "name_search", with: 'walk'
        click_on('検索')
        expect(page).to have_content 'walk'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        visit new_session_path
        fill_in "session_email", with: 'user_general@mail.com'
        fill_in "session_password", with: 'user_general'
        click_on('Log in')
        visit tasks_path
        select "未着手", from: 'status_search'
        click_on('検索')
        expect(page).not_to have_content 'play_sports'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        visit new_session_path
        fill_in "session_email", with: 'user_general@mail.com'
        fill_in "session_password", with: 'user_general'
        click_on('Log in')
        visit tasks_path
        fill_in "name_search", with: 'walk'
        select "未着手", from: 'status_search'
        click_on('検索')
        expect(page).not_to have_content 'shopping'
      end
    end
  end

end
