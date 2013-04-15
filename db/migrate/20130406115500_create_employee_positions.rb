class CreateEmployeePositions < ActiveRecord::Migration
  def change
    create_table :employee_positions do |t|
      t.integer :employee_id
      t.string :position
      t.integer :level

      t.timestamps
    end
  end
end
