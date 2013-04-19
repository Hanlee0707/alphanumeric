class SessionsController < ApplicationController
  def new
    path = request.path
    @is_employee= false
    if path.include? '/uploaders'
      @is_employee = true
    end
    if current_employee or current_user
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
