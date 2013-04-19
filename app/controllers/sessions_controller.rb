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
      respond_to do |format|
        if params[:uid] then
          format.json { render json: employee }
        else
          format.html {redirect_to home_path, :notice => "You have successfully logged in!"}
        end
      end
    else
      @not_valid = ["not valid"]
      respond_to do |format|
        if params[:uid] then
          format.json { render json: @not_valid }
        else
          format.html { redirect_to root_uploader_path, :notice => "Invalid email or password."}
        end
      end
    end
  end

  def destroy
    session[:employee_id] = nil
    redirect_to root_path, :notice => "You have successfully logged out."
  end
end
