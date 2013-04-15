class AddCreateAccountTokenToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :create_account_token, :string
    add_column :employees, :create_account_sent_at, :datetime
  end
end
