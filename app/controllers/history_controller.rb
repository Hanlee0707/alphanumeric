class HistoryController < ApplicationController
  before_filter :logged_in?

  def editor
    @history_editor_layout = true
    if employee_privilege("Editor") == false then
      respond_to do |format| 
        format.html { redirect_to home_url, notice: "You have no privilege to access this page."}
      end
    else
      @articles = Article.where("editor_id=? and status = ?", current_employee.id, "Archived").paginate page: params[:page], order: 'published_at desc, created_at desc', per_page: 20
      
      @ongoing_size = Article.where("editor_id = ? and (status = ? OR status = ? OR status = ?)", current_employee.id, "Assigned", "Being Written", "Revoked").size
      @review_size = Article.where("editor_id = ? and status = ?", current_employee.id, "Need Review").size
      @publish_size = Article.where("editor_id = ? and status = ?", current_employee.id, "Approved").size
      @archive_size = @articles.size
    end
  end

  def contributor
    @history_contributor_layout = true
    if employee_privilege("Contributor") == false then
      respond_to do |format| 
        format.html { redirect_to home_url, notice: "You have no privilege to access this page."}
      end
    else
      @articles = Article.where("contributor_id=? and (status = ? or status = ? or status = ?)", current_employee.id, "Approved", "Published", "Archived").paginate page: params[:page], order: 'published_at desc, created_at desc', per_page: 20     
      @ongoing_size = Article.where("contributor_id = ? and (status = ? OR status = ? OR status = ?)", current_employee.id, "Assigned", "Being Written", "Revoked").size
      @review_size = Article.where("contributor_id = ? and status = ?", current_employee.id, "Need Review").size
      @archive_size = @articles.size
    end
  end
end
