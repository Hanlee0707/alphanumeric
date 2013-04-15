class ChangeDataTypeForOccurred < ActiveRecord::Migration
  def up
    change_table :articles do |t|
      t.change :occurred, :datetime
    end
  end

  def down
    change_table :articles do |t|
      t.change :occurred, :date
    end
  end
end
