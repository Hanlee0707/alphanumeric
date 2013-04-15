class HomeController < ApplicationController
  before_filter :logged_in?

  def show
    @isEditor = false
    @isContributor = false
    @isAdministrator = false
    if employee_privilege("Editor") then
      @isEditor = true
      @editor_incomplete_count = Article.where("editor_id = ? and (status != ? and status !=?)", current_employee.id, "Published", "Archived").size
      @editor_published_count = Article.where("editor_id = ? and (status = ?)", current_employee.id, "Published").size
      @editor_archived_count = Article.where("editor_id = ? and (status = ?)", current_employee.id, "Archived").size
    end
    if employee_privilege("Contributor") then
      @isContributor = true
      @contributor_incomplete_count = Article.where("contributor_id = ? and (status != ? and status != ? and status != ?)", current_employee.id, "Approved", "Published", "Archived").size
      @contributor_published_count = Article.where("contributor_id = ? and (status = ?)", current_employee.id, "Published").size
      @contributor_archived_count = Article.where("contributor_id = ? and (status = ?)", current_employee.id, "Archived").size
    end
  end 

end
