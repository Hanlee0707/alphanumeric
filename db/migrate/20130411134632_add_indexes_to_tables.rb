class AddIndexesToTables < ActiveRecord::Migration
  def self.up
    add_index :employee_positions, :employee_id
    add_index :employees, :last_name
    add_index :employee_positions, :position
    add_index :articles, :contributor_id
  end

  def self.down
    remove_index :employee_positions, :employee_id
    remove_index :employees, :last_name
    remove_index :employee_positions, :position
    remove_index :articles, :contributor_id
  end
end
