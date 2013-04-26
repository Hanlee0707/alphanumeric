class PublishedController < ApplicationController
  before_filter :logged_in?
  before_filter :has_privilege?
  before_filter :set_attributes

  def set_attributes
    if request.path.include? "editor" then
      @editor_layout = true
    elsif request.path.include? "contributor" then
      @contributor_layout = true
    else
      @published_layout = true
    end
  end  

  def index
    @isContributor = false
    @isEditor = false
    if current_user then
      archived_article_ids = current_user.user_archived_articles.select(:article_id).map { |archived_article| archived_article.article_id }
      followed_article_ids = current_user.user_followed_articles.select(:article_id).map { |followed_article| followed_article.article_id }
      @articles = Article.where("status = ?", "Published")
      if archived_article_ids.present?
        @articles = @articles.where("id NOT IN (?)", archived_article_ids)
      end
      if followed_article_ids.present?
        @articles = @articles.where("id NOT IN (?)", followed_article_ids)
      end
      @articles=@articles.order('published_at desc, created_at desc').paginate page: params[:page], per_page: 20
      @articles.each { |article| 
        if !current_user.user_read_articles.find_by_article_id(article.id).nil? 
          article[:read]= true
        else
          article[:read] = false
        end
      }        
    elsif request.path.include? "editor"
      @isEditor = true
      @articles = Article.where("status = ?", "Published").order('published_at desc, created_at desc').paginate page: params[:page], per_page: 20
    else
      if params[:tag] then
        @articles = Article.tagged_with(params[:tag]).where("status = ?", "Published").order('published_at desc, created_at desc').paginate page: params[:page], per_page: 20
      else
        @articles = Article.where("status = ?", "Published").order('published_at desc, created_at desc').paginate page: params[:page], per_page: 20
      end
    end
    objects = []
    @articles.map { |article| 
      object = {}
      object[:article]=article
      object[:image]=article.images
      object[:numbers]=article.numbers
      object[:extra_informations]=article.extra_informations
      object[:additional_texts]=article.additional_texts
      object[:tag_list]=article.tag_list
      object[:issue_list]=article.issue_list
      object[:citations]=article.citations
      objects.append(object)
    }
    respond_to do |format| 
      format.html 
      format.json { render json: objects }
    end
  end

end
