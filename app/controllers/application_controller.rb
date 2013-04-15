class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_employee, :logged_in, :employee_privilege, :is_administrator, :is_editor, :is_contributor

  def employee_privilege(option)
    current_employee.employee_positions.each do |position|
      if position.position == option then
        return true
      end
    end
    return false
  end


  private
  def current_employee
    @current_employee ||= Employee.find_by_id(session[:employee_id]) if session[:employee_id]
  end

  def logged_in?
    if current_employee.present?
      @employee = current_employee
    else
      unless params[:controller] == "sessions" and params[:action] == "new"
        redirect_to root_path, notice: "Please log in first." and return
      end
    end
  end

  def is_administrator?
    isAdministrator = false
    current_employee.employee_positions.each do |position|
      if position.position == "Administrator" then
        isAdministrator = true
      end
    end
    if !isAdministrator then
      redirect_to home_path, notice: "You don't have the required privilege." and return 
    end
  end

  def is_contributor?
    isContributor = false
    current_employee.employee_positions.each do |position|
      if position.position == "Contributor" then
        isContributor = true
      end
    end
    if !isContributor then
      redirect_to home_path, notice: "You don't have the required privilege." and return 
    end
  end

  def is_editor?
    isEditor = false
    current_employee.employee_positions.each do |position|
      if position.position == "Editor" then
        isEditor = true
      end
    end
    if !isEditor then
      redirect_to home_path, notice: "You don't have the required privilege." and return 
    end
  end

end
