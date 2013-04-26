class ReviewController < ApplicationController
  before_filter :logged_in?
  before_filter :has_privilege?
  before_filter :select_layout

  def select_layout
    if request.path.include?("editor") then
      @editor_layout = true
    elsif request.path.include?("contributor") then
      @contributor_layout = true
    end
  end

  def index
    if request.path.include?("editor") 
      @articles = Article.where("editor_id=? and status = ?", current_employee.id, "Need Review").paginate page: params[:page], order: 'created_at desc', per_page: 20
    elsif request.path.include?("contributor")
      @articles = Article.where("contributor_id=? and status = ?", current_employee.id, "Need Review").paginate page: params[:page], order: 'created_at desc', per_page: 20
    else
      respond_to do |format| 
        format.html { redirect_to home_url, notice: "You can't access the page this way."}
      end
    end
  end

end
