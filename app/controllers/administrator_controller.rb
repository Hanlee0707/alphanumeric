class AdministratorController < ApplicationController
  before_filter :logged_in?
  before_filter :is_administrator?
  layout "administrator_layout"

  def show
    if params[:search] then
      @employees = Employee.search(params[:search]).paginate page: params[:page], order: 'last_name desc', per_page: 20
    else
      @employees = Employee.paginate page: params[:page], order: 'last_name desc', per_page: 20
    end
    @administrator = current_employee
  end

  def create
  end

  def edit
  end

  def destroy
  end

  def new
    
  end
end
