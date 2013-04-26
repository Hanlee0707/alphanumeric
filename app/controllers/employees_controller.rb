class EmployeesController < ApplicationController
  before_filter :logged_in?
  before_filter :has_privilege?
  before_filter :set_attributes

  def set_attributes
    if request.path.include? "administrator" then
      @administrator_layout = true
    else
      @employees_layout = true
    end
  end  

  def show
    begin
      @can_edit = false
      @can_delete = false
      if request.path.include? "administrator" then
        @can_edit = true
        @back_path = administrator_path
        @administrative = true
        if current_employee.id.to_s != params[:id] then
          @can_delete = true
        end
        @employee = Employee.find(params[:id])
        respond_to do |format|
          format.html # show.html.erb
          format.json { render json: @employee }
        end
      else
        @administrative = false
        @back_path = employees_path
        @employee = Employee.find(params[:id])
        respond_to do |format|
          format.html # show.html.erb
          format.json { render json: @employee }
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
      @employee = Employee.find(params[:id])
      @employees_layout = false
      if request.path.include? "administrator" then
        @administrative = true 
        @back_path = administrator_employee_path(params[:id])
      else
        if @current_employee.id.to_s == params[:id] 
          @administrative = false
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
      @employee = Employee.find(params[:id])
      if request.path.include? "administrator" then 
        administrative = true
        @employee.employee_positions.destroy_all
      else
        administrative = false
      end
      respond_to do |format|
        if (administrative and @employee.update_attribute('employee_positions_attributes',params[:employee][:employee_positions_attributes])) or (!administrative and @employee.update_attributes(params[:employee])) then
          if administrative then
            format.html { redirect_to administrator_employee_url(@employee), notice: "Employee was successfully updated." }
          else
            format.html { redirect_to home_path, notice: "Your account was successfully updated." }
          end
          format.json { head :no_content }
        else
          if administrative then
            @back_path = administrator_employee_path(params[:id])
          else
            @back_path = home_path
          end
          format.html { render action: "edit" }
          format.json { render json: @employee.errors, status: :unprocessable_entity }
        end
      end
    rescue ActiveRecord::RecordNotFound
      respond_to do |format|
        format.html { redirect_to home_path, notice: "That employee does not exist."}
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
