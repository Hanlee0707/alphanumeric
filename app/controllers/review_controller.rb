class ReviewController < ApplicationController
  before_filter :logged_in?
  before_filter :has_privilege?
  before_filter :select_layout

  def select_layout
    @workspace_layout = true
  end

  def index
    @isContributor = false
    @isEditor = false
    if employee_privilege("Editor") then
      @isEditor = true
      if current_employee.employee_positions.find_by_position("Editor").level > 1 then
        @articles = Article.where("status = ?", "Need Review").paginate page: params[:page], order: 'created_at desc', per_page: 20
      else
        @articles = Article.where("editor_id = ? and status = ?", current_employee.id, "Need Review").paginate page: params[:page], order: 'created_at desc', per_page: 20
      end
    elsif employee_privilege("Contributor") then
      @isContributor = true
      @articles = Article.where("contributor_id=? and status = ?", current_employee.id, "Need Review").paginate page: params[:page], order: 'created_at desc', per_page: 20
    else
      respond_to do |format| 
        format.html { redirect_to home_url, notice: "You can't access the page this way."}
      end
    end
  end

end
