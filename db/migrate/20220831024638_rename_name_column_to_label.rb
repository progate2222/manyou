class RenameNameColumnToLabel < ActiveRecord::Migration[6.1]
  def change
    rename_column :labels, :name, :title
  end
end
