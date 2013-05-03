class EmployeesController < ApplicationController
  before_filter :logged_in?
  before_filter :has_privilege?
  before_filter :set_attributes

  def set_attributes
    if request.path.include? "employees" then
      @employees_layout = true
    end
  end  

  def show
    begin
      @can_edit = false
      @can_delete = false
      if employee_privilege("Administrator") and current_employee.employee_positions.find_by_position("Administrator").level > 1 then
        @can_edit = true
        @back_path = employees_path
        @administrative = true
        if current_employee.id.to_s != params[:id] then
          @can_delete = true
        end
        @employee = Employee.find(params[:id])
        respond_to do |format|
          format.html # show.html.erb
        end
      elsif employee_privilege("Editor") then
        @administrative = false
        @back_path = employees_path
        @employee = Employee.find(params[:id])
        respond_to do |format|
          format.html # show.html.erb
        end
      else
        respond_to do |format|
          format.html {redirect_to home_path, notice: "You can't view other employees' information."} 
        end
      end
    rescue ActiveRecord::RecordNotFound
      respond_to do |format|
        format.html { redirect_to home_path, notice: "That employee does not exist."}
      end
    end
  end

  def edit
    begin
       @employees_layout = false
      if request.path.include? "admin_edit" and employee_privilege("Administrator") then
        @administrative = true 
        @employee = Employee.find(params[:id])
        @back_path = employee_path(@employee)
      else
        if request.path.include? "edit_personal" then
          @administrative = false
          @employee = Employee.find(current_employee.id)
          @back_path = home_path
        else
          respond_to do |format|
            format.html { redirect_to home_path, notice: "You can't edit other employees' personal information." }
          end
        end
      end
    rescue ActiveRecord::RecordNotFound
      respond_to do |format|
        format.html { redirect_to home_path, notice: "That employee does not exist."}
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
        format.html { redirect_to administrator_url, notice: 'Employee was successfully created.' }
        #     format.json
      end 
    else
      render 'new'
    end
  end


  def update
    begin
      if request.env['HTTP_REFERER'].include? "admin_edit" and employee_privilege("Administrator") then 
        @employee = Employee.find(params[:id])
        administrative = true
        @employee.employee_positions.destroy_all
        respond_to do |format|
          if (administrative and @employee.update_attribute('employee_positions_attributes',params[:employee][:employee_positions_attributes])) then
            format.html { redirect_to employee_url(@employee), notice: "Employee was successfully updated." }
          else
            format.html { render action: "edit" }
            format.json { render json: @employee.errors, status: :unprocessable_entity }
          end
        end
      elsif request.env['HTTP_REFERER'].include? "edit_personal" then
        administrative = false
        @employee = Employee.find(current_employee.id)
        respond_to do |format|
          if (!administrative and @employee.update_attributes(params[:employee])) then
            format.html { redirect_to home_url, notice: "Your account was successfully updated." }
          else
            format.html { render action: "edit" }
            format.json { render json: @employee.errors, status: :unprocessable_entity }
          end
        end
      else
        respond_to do |format|
          format.html { redirect_to home_url, notice: "You don't have the required privilege."}
        end        
      end
    rescue ActiveRecord::RecordNotFound
      respond_to do |format|
        format.html { redirect_to home_url, notice: "That employee does not exist."}
      end
    end
  end

  def destroy
    begin
      @employee = Employee.find(params[:id])
      @employee.destroy    
      respond_to do |format|
        format.html { redirect_to administrator_path }
        format.json { head :no_content }
      end
    rescue ActiveRecord::RecordNotFound
      respond_to do |format|
        format.html { redirect_to home_path, notice: "That employee does not exist."}
      end
    end
  end

  def index
    if params[:search] then
      @employees = Employee.search(params[:search]).paginate page: params[:page], order: 'last_name desc', per_page: 20
    else
      @employees = Employee.paginate page: params[:page], order: 'last_name desc', per_page: 20
    end
  end


end
