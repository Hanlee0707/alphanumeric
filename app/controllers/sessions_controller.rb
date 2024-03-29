class SessionsController < ApplicationController
  def new
    path = request.path

    @signin_layout= true
    if path.include? "staff" then
      @is_employee = true
    else
      @is_employee = false
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
    authenticated = false
    isUser = false
    isEmployee= false
    if params[:uid] or params[:user] then
      personnel = User.where("lower(email) = lower(?)", params[:email]).first 
    else
      personnel = Employee.where("lower(email) = lower(?)", params[:email]).first 
    end
    if personnel && personnel.authenticate(params[:password]) then
      authenticated = true
      if params[:uid] or params[:user] then
        isUser = true
      else
        isEmployee = true
      end
    end

    if authenticated then
      if isUser then
        session[:user_id] = personnel.id
      elsif isEmployee then
        session[:employee_id] = personnel.id
      end
      personnel.latest_login_at = Time.now
      personnel.save
      respond_to do |format|
        if params[:uid] then
          format.json { render json: ["Success!"] }
        else
          if isEmployee then
            format.html {redirect_to home_path, :notice => "You have successfully logged in!"}
          elsif isUser then
            format.html {redirect_to user_home_path, :notice => "You have successfully logged in!"}
          end
        end
      end
    else
      @not_valid = ["not valid"]
      respond_to do |format|
        if params[:uid] then
          format.json { render json: @not_valid }
        elsif params[:user] then
          format.html { redirect_to root_path, :notice => "Invalid email or password."}
        else
          format.html { redirect_to root_uploader_path, :notice => "Invalid email or password."}
        end
      end
    end
  end

  def destroy
    session[:employee_id] = nil
    session[:user_id] = nil
    if request.env['HTTP_REFERER'].include? 'staff' then
      redirect_to root_uploader_path, :notice => "You have successfully logged out."
    else
      redirect_to root_path, :notice => "You have successfully logged out."
    end
  end
end
