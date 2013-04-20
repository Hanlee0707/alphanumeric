class ResetPasswordController < ApplicationController

  def new
    path = request.path
    if path.include? "uploaders" then
      @through_user = false
    else
      @through_user = true
    end
  end

  def create
    path = request.path
    if path.include? "uploaders" then
      employee = Employee.find_by_email(params[:email])
      employee.send_password_reset if employee
      redirect_to root_uploader_url, :notice => "Email sent with password reset instructions."
    else
      user = User.find_by_email(params[:email])
      user.send_password_reset if user
      redirect_to root_url, :notice => "Email sent with password reset instructions."
    end
  end

  def edit
    path = request.path
    if path.include? "uploaders" then
      @employee = Employee.find_by_password_reset_token!(params[:id])
    else
      @user = User.find_by_password_reset_token!(params[:id])
    end
  end

  def update
    path = request.path
    if path.include? "uploaders" then
      @employee = Employee.find_by_password_reset_token!(params[:id])
      if @employee.password_reset_sent_at < 2.hours.ago
        redirect_to new_reset_password_path,
        :alert => "Password reset token has expired. Please try again."
      elsif @employee.update_attributes(params[:employee])
        redirect_to root_uploader_url, :notice => "Password has been successfully reset!"
      else
        render :edit
      end
    else
      @user = User.find_by_password_reset_token!(params[:id])
      if @user.password_reset_sent_at < 2.hours.ago
        redirect_to new_user_reset_password_path,
        :alert => "Password reset token has expired. Please try again."
      elsif @user.update_attributes(params[:user])
        redirect_to root_url, :notice => "Password has been successfully reset!"
      end    
    end
  end

end
