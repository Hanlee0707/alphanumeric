class ArchivedController < ApplicationController
  before_filter :logged_in?
  before_filter :set_attributes

  def set_attributes
    @archived_layout = true
  end

  def index
    @articles = Article.joins(:archived_articles).where("user_id = ?", current_user.id).paginate page: params[:page], order: 'created_at desc', per_page: 20
    objects = []
    @articles.map { |article| 
      object = {}
      object[:article]=article
      object[:image]=article.images
      object[:numbers]=article.numbers
      object[:extra_informations]=article.extra_informations
      object[:additional_texts]=article.additional_texts
      object[:tag_list]=article.tag_list
      objects.append(object)
    }
    respond_to do |format| 
      format.html 
      format.json { render json: objects }
    end
  end
end
