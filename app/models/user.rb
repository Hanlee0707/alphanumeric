class User < ActiveRecord::Base
  has_secure_password
  
  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :password_reset_sent_at, :password_reset_token, :updating_password
  attr_accessor :updating_password
  validates :email, :presence => :true,
                    :uniqueness => {:case_sensitive => false},
                    :length => {:minimun => 3, :maximum => 50},
                    :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}
  validates :password, presence: true,  length: {:minimum => 8, :maximum => 20},:if => :should_validate_password?
  validates :first_name, :presence => :true
  validates :last_name, :presence => :true

  has_many :user_archived_articles, :dependent => :destroy
  has_many :user_read_articles, :dependent => :destroy
  has_many :user_followed_articles, :dependent => :destroy

  VALID_PASSWORD_REGEX = /^[\S]+$/
  validates :password, format: { with: VALID_PASSWORD_REGEX }

  def should_validate_password?
    updating_password==true || new_record?
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.update_attribute(:password_reset_sent_at, Time.zone.now)
    UserMailer.reset_password(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
