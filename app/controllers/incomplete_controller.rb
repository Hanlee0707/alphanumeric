class IncompleteController < ApplicationController
  before_filter :logged_in?
  before_filter :select_layout

  def select_layout
    if params[:editor_id] and employee_privilege("Editor") then
      @editor_layout = true
    elsif params[:contributor_id] and employee_privilege("Contributor") then
      @contributor_layout = true
    end
  end

  def index
    @isEditor = false
    @isContributor = false
    if params[:editor_id] and current_employee.id.to_s == params[:editor_id]
      @isEditor = true
      @articles = Article.where("editor_id=? and (status = ? OR status = ? OR status =?)", params[:editor_id], "Assigned", "Being Written", "Revoked").paginate page: params[:page], order: 'created_at desc', per_page: 20
    elsif params[:contributor_id] and current_employee.id.to_s == params[:contributor_id]
      @isContributor = true
      @articles = Article.where("contributor_id=? and (status = ? OR status = ? OR status =?)", params[:contributor_id], "Assigned", "Being Written", "Revoked").paginate page: params[:page], order: 'created_at desc', per_page: 20
    else
      respond_to do |format| 
        format.html { redirect_to home_url, notice: "You can't access the page this way."}
      end
    end
  end
end
