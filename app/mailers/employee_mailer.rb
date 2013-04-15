class EmployeeMailer < ActionMailer::Base
  default from: "han.lee0707@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.employee_mailer.create_account.subject
  #
  def create_account(employee)
    @employee = employee
    mail to: employee.email, :subject => "GIST: Welcome aboard. Verify your account!"
  end

  def notify_new_article(employee, title)
    @employee = employee
    @title = title
    mail to: employee.email, :subject => "GIST: You have a new article to write."
  end

  def notify_delete_article(employee, title, reason)
    @employee = employee
    @title = title
    @reason = reason
    mail to: employee.email, :subject => "GIST: Your article has been canceled."
  end

  def notify_revoke_article(employee, title, reason)
    @employee = employee
    @title = title
    @reason = reason
    mail to: employee.email, :subject => "GIST: Your article has been revoked."
  end

  def notify_review_article(employee, title)
    @employee = employee
    @title = title
    mail to: employee.email, :subject => "GIST: You have a new article that needs to get reviewed."
  end

  def notify_publish_article(employee, title)
    @employee = employee
    @title = title
    mail to: employee.email, :subject => "GIST: Your article has just been published."
  end

end
