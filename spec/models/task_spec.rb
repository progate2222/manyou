require 'rails_helper'
describe 'タスクモデル機能', type: :model do

  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(name: '', detail: '失敗テスト')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(name: '失敗テスト', detail: '')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(name: '成功テスト', detail: '成功テスト')
        expect(task).to be_valid
      end
    end
  end

  describe '検索機能' do
    let!(:task1) { FactoryBot.create(:task, name: 'first_task', status: "未着手") }
    let!(:task2) { FactoryBot.create(:task, name: 'second_task', status: "着手中") }
    let!(:task3) { FactoryBot.create(:task, name: 'third_task', status: "完了") }
    let!(:task4) { FactoryBot.create(:task, name: 'forth_task', status:"未着手") }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it '検索キーワードを含むタスクが絞り込まれる' do
        expect(Task.name_search('first')).to include(task1)
        expect(Task.name_search('first')).not_to include(task2)
        expect(Task.name_search('first')).not_to include(task3)
        expect(Task.name_search('first')).not_to include(task4)
        expect(Task.name_search('first').count).to eq 1
      end
    end
    context '検索フォームにステータスのみ入力されている場合' do
      it 'scopeメソッドでステータス検索ができる' do
        expect(Task.status_search('着手中')).not_to include(task1)
        expect(Task.status_search('着手中')).to include(task2)
        expect(Task.status_search('着手中')).not_to include(task3)
        expect(Task.status_search('着手中')).not_to include(task4)
        expect(Task.status_search('着手中').count).to eq 1
      end
    end
    context '検索フォームにタイトルとステータスが入力されている場合' do
      it 'scopeメソッドでタイトルとステータスの両方が検索できる' do
        expect(Task.name_search('first').status_search('未着手')).to include(task1)
        expect(Task.name_search('first').status_search('未着手')).not_to include(task2)
        expect(Task.name_search('first').status_search('未着手')).not_to include(task3)
        expect(Task.name_search('first').status_search('未着手')).not_to include(task4)
        expect(Task.name_search('first').status_search('未着手').count).to eq 1
      end
    end
  end

end
