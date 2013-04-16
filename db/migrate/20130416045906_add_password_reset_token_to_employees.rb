class AddPasswordResetTokenToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :password_reset_token, :string
  end
end
