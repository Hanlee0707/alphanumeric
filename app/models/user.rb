class User < ActiveRecord::Base
  attr_accessible :create_account_sent_at, :create_account_token, :email, :first_name, :last_name, :password_digest, :password_reset_sent_at, :password_reset_token
end
