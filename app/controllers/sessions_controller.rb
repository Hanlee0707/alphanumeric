class SessionsController < ApplicationController
  def new
    path = request.path

    @is_employee= false
    if path.include? '/uploaders'
      @employee_layout = true
      @is_employee = true
    else
      @user_layout = true
    end
    if current_employee then
      redirect_to home_path
    elsif current_user then
      redirect_to user_home_path
    else
      render "new"
    end
  end

  def create
    if params[:user] then
      personnel = User.find_by_email(params[:email])
    else
      personnel = Employee.find_by_email(params[:email])
    end
    if personnel && personnel.authenticate(params[:password])
      if params[:user] then
        session[:user_id] = personnel.id
      else
        session[:employee_id] = personnel.id
      end
      personnel.latest_login_at = Time.now
      personnel.save
      respond_to do |format|
        if params[:uid] then
          format.json { render json: personnel }
        else
          if params[:user] then 
            format.html {redirect_to user_home_path, :notice => "You have successfully logged in!"}
          else
            format.html {redirect_to home_path, :notice => "You have successfully logged in!"}
          end
        end
      end
    else
      @not_valid = ["not valid"]
      respond_to do |format|
        if params[:uid] then
          format.json { render json: @not_valid }
        else
          if params[:user] then
            format.html { redirect_to root_path, :notice => "Invalid email or password."}
          else
            format.html { redirect_to root_uploader_path, :notice => "Invalid email or password."}
          end
        end
      end
    end
  end

  def destroy
    session[:employee_id] = nil
    session[:user_id] = nil
    redirect_to root_path, :notice => "You have successfully logged out."
  end
end
