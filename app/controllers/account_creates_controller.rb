class AccountCreatesController < ApplicationController
  def new
    
  end
  
  def edit
    session[:employee_id] = nil
    @employee = Employee.find_by_create_account_token!(params[:id])
    if !@employee.account_create_time.nil? then
      redirect_to home_path, :notice => "You are already registered!"
    end
  end
  
  def update
     @employee = Employee.find_by_create_account_token!(params[:id])
     if @employee.update_attributes(params[:employee])
       session[:employee_id]=@employee.id
       redirect_to home_path, :notice => "Registration complete!"
     else
       render :edit
     end
  end

  def create
    @employee = Employee.find_by_email(params[:email])
  end

end
