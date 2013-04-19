class ArchivedController < ApplicationController
  before_filter :logged_in?
  before_filter :set_attributes

  def set_attributes
    @archived_layout = true
  end

  def index
    if params[:tag] then
      @articles = Article.tagged_with(params[:tag]).where("status = ?", "Archived").paginate page: params[:page], order: 'created_at desc', per_page: 20
    else
      @articles = Article.where("status = ?", "Archived").paginate page: params[:page], order: 'created_at desc', per_page: 20
    end
  end
end
