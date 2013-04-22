class PublishedController < ApplicationController
  before_filter :logged_in?
  before_filter :set_attributes

  def set_attributes
    if params[:editor_id] and employee_privilege("Editor") then
      @editor_layout = true
    elsif params[:contributor_id] and employee_privilege("Contributor") then
      @contributor_layout = true
    else
      @published_layout = true
    end
  end  

  def index
    @isEditor = false
    @isContributor = false
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
    elsif params[:editor_id] and current_employee.id.to_s == params[:editor_id]
      @isEditor = true
      @articles = Article.where("status = ?", "Published").order('published_at desc, created_at desc').paginate page: params[:page], per_page: 20
    elsif params[:contributor_id] and current_employee.id.to_s == params[:contributor_id]
      @isContributor = true
      @articles = Article.where("contributor_id=? and status = ?", params[:contributor_id], "Published").order('published_at desc, created_at desc').paginate page: params[:page], per_page: 20
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
      object[:citations]=article.citations
      objects.append(object)
    }
    respond_to do |format| 
      format.html 
      format.json { render json: objects }
    end
  end

end
