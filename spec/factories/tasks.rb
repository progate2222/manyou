# 「FactoryBotを使用します」という記述
FactoryBot.define do
  # 作成するテストデータの名前を「task」とします
  # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
  factory :task do
    name { 'Factoryで作ったデフォルトのタスク名1' }
    detail { 'Factoryで作ったデフォルトのタスク詳細1' }
    deadline { '2022-08-31' }
    status { '未着手' }
    priority{ 0 }
  end
  # 作成するテストデータの名前を「second_task」とします
  # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
  factory :second_task, class: Task do
    name { 'Factoryで作ったデフォルトのタイトル2' }
    detail { 'Factoryで作ったデフォルトのコンテント2' }
    deadline { '2022-09-30' }
    status { '着手中' }
    priority{ 2 }
  end
end
