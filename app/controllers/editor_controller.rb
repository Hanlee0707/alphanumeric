class EditorController < ApplicationController
  before_filter :logged_in?
  before_filter :is_editor?
  layout "editor_layout"

  def show
    @articles = Article.joins(:published_item).paginate page: params[:page], per_page: 20
    respond_to do |format| 
      format.html 
      format.json { render json: @articles }
    end
  end

  def remove
    @published_items = PublishedItem.all
    @published_items.each do |item|
      if not params[:"article_#{item.article_id}"].nil? then
        item.destroy
      end
    end
    respond_to do |format|
      format.html { redirect_to published_list_url, notice: 'Article was successfully removed from the list.' }
    end
  end

end
