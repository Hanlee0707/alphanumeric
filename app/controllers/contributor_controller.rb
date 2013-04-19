class ContributorController < ApplicationController
  before_filter :logged_in?
  before_filter :is_contributor?
  before_filter :set_contributor

  def set_contributor 
    @contributor_layout= true
  end


  def show
    @articles = Article.where("status = ? OR status = ?", "Assigned", "Being Written").paginate page: params[:page], order: 'created_at desc', per_page: 20
    respond_to do |format| 
      format.html 
      format.json { render json: @articles }
    end
  end

end
