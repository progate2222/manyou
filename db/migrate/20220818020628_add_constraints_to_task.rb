class AddConstraintsToTask < ActiveRecord::Migration[6.1]
  change_column :tasks, :name, :text, null: false
end
