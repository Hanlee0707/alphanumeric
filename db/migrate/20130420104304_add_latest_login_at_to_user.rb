class AddLatestLoginAtToUser < ActiveRecord::Migration
  def change
    add_column :users, :latest_login_at, :datetime
  end
end
