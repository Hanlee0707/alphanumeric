class ResetPasswordController < ApplicationController

  def new

  end

  def create
    employee = Employee.find_by_email(params[:email])
    employee.send_password_reset if employee
    redirect_to root_uploader_url, :notice => "Email sent with password reset instructions."
  end

  def edit
    @employee = Employee.find_by_password_reset_token!(params[:id])
  end

  def update
    @employee = Employee.find_by_password_reset_token!(params[:id])
    if @employee.password_reset_sent_at < 2.hours.ago
      redirect_to new_reset_password_path,
                  :alert => "Password reset token has expired. Please try again."
    elsif @employee.update_attributes(params[:employee])
      redirect_to root_uploader_url, :notice => "Password has been successfully reset!"
    else
      render :edit
    end
  end

end
