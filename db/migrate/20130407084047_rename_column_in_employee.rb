class RenameColumnInEmployee < ActiveRecord::Migration
  def up
    rename_column :employees, :name, :first_name
  end

  def down
    rename_column :employees, :first_name, :name
  end
end
