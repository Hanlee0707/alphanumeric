class ArchivedController < ApplicationController
  before_filter :logged_in?
  before_filter :set_attributes

  def set_attributes
    @archived_layout = true
  end

  def index
    @articles = Article.joins(:user_archived_articles).where("user_id = ?", current_user.id).paginate page: params[:page], order: 'published_at desc, created_at desc', per_page: 20
    @articles.each { |article| 
      if !current_user.user_read_articles.find_by_article_id(article.id).nil? 
        article[:read]= true
      else
        article[:read] = false
      end
    }        
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
