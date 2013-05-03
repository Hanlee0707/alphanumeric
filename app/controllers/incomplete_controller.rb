class IncompleteController < ApplicationController
  before_filter :logged_in?
  before_filter :select_layout

  def select_layout
    if request.path.include?("workspace") then
      @workspace_layout = true
    end
  end

  def index
    @isEditor = false
    @isContributor = false
    if employee_privilege("Editor") then
      @isEditor = true
      if current_employee.employee_positions.find_by_position("Editor").level > 1 then
        @articles = Article.where("(status = ? OR status = ? OR status =?)", "Assigned", "Being Written", "Revoked").paginate page: params[:page], order: 'created_at desc', per_page: 20
      else
        @articles = Article.where("editor_id=? and (status = ? OR status = ? OR status =?)", current_employee.id, "Assigned", "Being Written", "Revoked").paginate page: params[:page], order: 'created_at desc', per_page: 20
      end
    elsif employee_privilege("Contributor") then
      @isContributor = true
      @articles = Article.where("contributor_id=? and (status = ? OR status =?)", current_employee.id, "Being Written", "Revoked").paginate page: params[:page], order: 'created_at desc', per_page: 20
    else
      respond_to do |format| 
        format.html { redirect_to home_url, notice: "Invalid access."}
      end
    end
  end
end
