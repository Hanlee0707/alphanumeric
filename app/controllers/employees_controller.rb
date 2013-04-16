class EmployeesController < ApplicationController
  # before_filter :logged_in?
  layout :select_layout
  def select_layout
    if params[:administrator_id] and employee_privilege("Administrator") then
      'administrator_layout'
    else
      'application'
    end
  end  

  def show
    if params[:administrator_id] and params[:administrator_id]!=current_employee.id.to_s then
        respond_to do |format|
          format.html { redirect_to home_path, notice: "Invalid access." }
        end
    else
      if params[:administrator_id] or params[:id]==current_employee.id.to_s then
        @can_edit = true
        if params[:administrator_id] then
          @back_path = administrator_path(params[:administrator_id])
          if params[:id] == current_employee.id.to_s then
            @administrative = false
          else
            @administrative= true
          end
        else
          @back_path = home_path
          @administrative = false
        end
      else
        @administrative = false
        @can_edit = false
        @back_path = home_path
      end
      @employee = Employee.find(params[:id])
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @employee }
      end
    end
  end

  def edit
    @employee = Employee.find(params[:id])
    @current_employee = current_employee
    if params[:administrator_id] 
      if params[:administrator_id]== @current_employee.id.to_s 
        @administrative = true 
      else
        respond_to do |format|
          format.html { redirect_to home_path, notice: "You don't have the required privilege." }
        end
      end
    else
      if @current_employee.id.to_s == params[:id] 
        @administrative = false
      else
        respond_to do |format|
          format.html { redirect_to home_path, notice: "You can't edit other employees' personal information." }
        end
      end
    end
  end

  def new
    @employee = Employee.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @employee }
    end
  end

  def create
    @employee = Employee.new(params[:employee])

   if @employee.save
     @employee.send_create_account
      respond_to do |format|
        format.html { redirect_to administrator_url(current_employee), notice: 'Employee was successfully created.' }
   #     format.json
      end 
    else
      render 'new'
    end
  end


  def update
    @employee = Employee.find(params[:id])
    if params[:administrator_id] and current_employee.id.to_s == params[:administrator_id] then
      administrative = true
      @employee.employee_positions.destroy_all
    else
      administrative = false
    end

    respond_to do |format|
      if @employee.update_attributes(params[:employee])
        if administrative then
          format.html { redirect_to administrator_employee_url(current_employee, @employee), notice: "Employee was successfully updated." }
        else
         format.html { redirect_to @employee, notice: "Employee was successfully updated." }
        end
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy
    
    respond_to do |format|
      format.html { redirect_to administrator_path(current_employee) }
      format.json { head :no_content }
    end
  end
end
