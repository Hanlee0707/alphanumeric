class SessionsController < ApplicationController
  def new
    if current_employee
      redirect_to home_path
    else
      render "new"
    end
  end

  def create
    employee = Employee.find_by_email(params[:email])
    if employee && employee.authenticate(params[:password])
      session[:employee_id] = employee.id
      employee.latest_login_at = Time.now
      employee.save
      redirect_to home_path, :notice => "You have successfully logged in!"
    else
      redirect_to  new_session_path, :notice => "Invalid email or password."
    end
  end

  def destroy
    session[:employee_id] = nil
    redirect_to root_path, :notice => "You have successfully logged out."
  end
end
