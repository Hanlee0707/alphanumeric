class UserMailer < ActionMailer::Base
  default from: "han.lee0707@gmail.com"

  def reset_password(user)
    @user = user
    mail to: user.email, :subject => "GIST: Reset password link for your account."
  end

end
