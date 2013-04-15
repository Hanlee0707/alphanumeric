class ArchivedController < ApplicationController
  before_filter :logged_in?
  layout 'archived_layout'

  def index
    if params[:tag] then
      @articles = Article.tagged_with(params[:tag]).where("status = ?", "Archived").paginate page: params[:page], order: 'created_at desc', per_page: 20
    else
      @articles = Article.where("status = ?", "Archived").paginate page: params[:page], order: 'created_at desc', per_page: 20
    end
  end
end
