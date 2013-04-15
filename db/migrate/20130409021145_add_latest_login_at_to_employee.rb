class AddLatestLoginAtToEmployee < ActiveRecord::Migration
  def change
    add_column :employees, :latest_login_at, :datetime
  end
end
