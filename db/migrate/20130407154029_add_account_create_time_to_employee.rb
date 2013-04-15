class AddAccountCreateTimeToEmployee < ActiveRecord::Migration
  def change
    add_column :employees, :account_create_time, :datetime
  end
end
