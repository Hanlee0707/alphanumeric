class UserMailer < ActionMailer::Base
  default from: "support@gist.gs"

  def reset_password(user)
    @user = user
    mail to: user.email, :subject => "GIST: Reset password link for your account."
  end

end
