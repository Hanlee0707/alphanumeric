class Employee < ActiveRecord::Base
  has_secure_password

  scope :contributor_only, joins(:employee_positions).where('position LIKE ?', "%Contributor%")

  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :employee_positions_attributes, :email_confirmation, :account_create_time, :updating_password
  attr_accessor :email_confirmation, :updating_password, :name
  validates_presence_of :email, :password, :first_name, :last_name, :on => :create
  validates :email, :uniqueness => {:case_sensitive => false }, length: { minimum: 3, maximum: 50}

  has_many :employee_positions, dependent: :destroy 
  has_many :employee_position_types, :through => :employee_positions
  has_many :articles, :foreign_key => 'contributor_id'
  
  validates :password, presence: true, length: {minimum: 8}, :if => :should_validate_password?
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }

  validate :check_email_confirmation, :on => :create
  accepts_nested_attributes_for :employee_positions, allow_destroy: true, reject_if: lambda { |a| a[:position].blank? || a[:level].blank? }
  validate :validate_positions
  
  def should_validate_password?
    updating_password==true || new_record?
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    EmployeeMailer.reset_password(self).deliver
  end

  def send_create_account
    generate_token(:create_account_token)
    self.create_account_sent_at = Time.zone.now
    save!
    EmployeeMailer.create_account(self).deliver
  end

  def notify_new_article(title)
    EmployeeMailer.notify_new_article(self, title).deliver
  end

  def notify_review_article(title)
    EmployeeMailer.notify_review_article(self, title).deliver
  end

  def notify_delete_article(title, reason)
    EmployeeMailer.notify_delete_article(self, title, reason).deliver
  end

  def notify_revoke_article(title, reason)
    EmployeeMailer.notify_revoke_article(self, title, reason).deliver
  end

  def notify_publish_article(title)
    EmployeeMailer.notify_publish_article(self, title).deliver
  end

  def validate_positions
    if self.employee_positions.size > 0 then
      return true
    else
      self.errors[:base] << "Check at least one position."
      return false
    end    
  end
  
  def check_email_confirmation
    if self.email == self.email_confirmation then
      return true
    else
      self.errors[:base] << "email and email confirmation are different."
      return false
    end
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while Employee.exists?(column => self[column])
  end

  def self.search(search)
    if search then 
      where('first_name LIKE ? or last_name LIKE ? or email LIKE ?', "%#{search}%","%#{search}%","%#{search}%")
    else
      scoped
    end
  end
  
  def self.contributor_only
    joins(:employee_positions).where('position LIKE ?', "%Contributor%")
  end
  
  def full_name_with_email
    "#{self.first_name} #{self.last_name} (#{self.email})"
  end

end
