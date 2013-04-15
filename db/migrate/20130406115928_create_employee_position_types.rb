class CreateEmployeePositionTypes < ActiveRecord::Migration
  def change
    create_table :employee_position_types do |t|
      t.string :position_type
      t.integer :number_of_levels

      t.timestamps
    end
  end
end
