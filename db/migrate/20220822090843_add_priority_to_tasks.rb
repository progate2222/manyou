class AddPriorityToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :status, :string, default: "ĉŞçĉ"
    add_column :tasks, :priority, :integer, default: 0
  end
end
