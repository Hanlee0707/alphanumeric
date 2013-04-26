class IncompleteController < ApplicationController
  before_filter :logged_in?
  before_filter :select_layout

  def select_layout
    if request.path.include?("editor") then
      @editor_layout = true
    elsif request.path.include?("contributor") then
      @contributor_layout = true
    end
  end

  def index
    @isEditor = false
    @isContributor = false
    if request.path.include?("editor") 
      @isEditor = true
      @articles = Article.where("editor_id=? and (status = ? OR status = ? OR status =?)", current_employee.id, "Assigned", "Being Written", "Revoked").paginate page: params[:page], order: 'created_at desc', per_page: 20
    elsif request.path.include?("contributor")
      @isContributor = true
      @articles = Article.where("contributor_id=? and (status = ? OR status = ? OR status =?)", current_employee.id, "Assigned", "Being Written", "Revoked").paginate page: params[:page], order: 'created_at desc', per_page: 20
    else
      respond_to do |format| 
        format.html { redirect_to home_url, notice: "Invalid access."}
      end
    end
  end
end
