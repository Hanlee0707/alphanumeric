class ApprovedController < ApplicationController
  before_filter :logged_in?
  before_filter :has_privilege?
  before_filter :select_layout
  def select_layout
    if request.path.include? "editor" and employee_privilege("Editor") then
      @editor_layout = true
    elsif request.path.include? "contributor" and employee_privilege("Contributor") then
      @contributor_layout = true
    end
  end

  def index
    @isEditor = false
    @isContributor = false
    if request.path.include? "editor" then
      @isEditor = true
      @articles = Article.where("editor_id=? and status = ?", current_employee.id, "Approved").paginate page: params[:page], order: 'created_at desc', per_page: 20
    elsif request.path.include? "contributor" then
      @isContributor = true
      @articles = Article.where("contributor_id=? and status = ?", current_employee.id, "Approved").paginate page: params[:page], order: 'created_at desc', per_page: 20
    else
      respond_to do |format| 
        format.html { redirect_to home_url, notice: "You can't access the page this way."}
      end
    end
  end

end
