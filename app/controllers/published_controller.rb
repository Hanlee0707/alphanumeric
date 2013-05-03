class PublishedController < ApplicationController
  before_filter :logged_in?
  before_filter :has_privilege?
  before_filter :set_attributes
  helper_method :sort_column, :sort_direction

  def set_attributes
    if request.path.include? "workspace" then
      @workspace_layout = true
    elsif request.path.include? "published" then
      @published_layout = true
    end
  end  

  def index
    @isContributor = false
    @isEditor = false
    if params[:direction] then
      if params[:direction] == "desc" then
        @direction = "asc"
      else
        @direction = "desc"
      end
    else
      @direction = "asc"
    end
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
      if sort_column == "published_at" then
        @articles = @articles.order(sort_column+ " " + sort_direction).paginate(:per_page => 20, :page => params[:page])
      else
        if sort_direction == "desc" then
          order_words = "category != 'US', category != 'World', category !='Politics', category !='Economy', category!='Technology'"
        else
          order_words = "category != 'Technology', category != 'Economy', category !='Politics', category !='World', category!='US'"
        end
        @articles = @articles.order(order_words).paginate(:per_page => 20, :page => params[:page])
      end
      @articles.each { |article| 
        if !current_user.user_read_articles.find_by_article_id(article.id).nil? 
          article[:read]= true
        else
          article[:read] = false
        end
      }        
    elsif employee_privilege("Editor") and @workspace_layout then
      @isEditor = true
      if current_employee.employee_positions.find_by_position("Editor").level > 1 then 
        @articles = Article.where("status =?", "Published").order(sort_column+ " " + sort_direction).paginate(:per_page => 20, :page => params[:page])
      else
        @articles = Article.where("editor_id = ? and status = ?", current_employee.id, "Published").order('published_at desc, created_at desc').paginate page: params[:page], per_page: 20
      end
    else
      if params[:tag] then
        @articles = Article.tagged_with(params[:tag]).where("status = ?", "Published").order('published_at desc, created_at desc').paginate page: params[:page], per_page: 20
      else
        @articles = Article.where("status = ?", "Published")
        if sort_column == "published_at" then
          @articles = @articles.order(sort_column+ " " + sort_direction).paginate(:per_page => 20, :page => params[:page])
        else
          if sort_direction == "desc" then
            order_words = "category != 'US', category != 'World', category !='Politics', category !='Economy', category!='Technology'"
          else
            order_words = "category != 'Technology', category != 'Economy', category !='Politics', category !='World', category!='US'"
          end
          @articles = @articles.order(order_words).paginate(:per_page => 20, :page => params[:page])
        end
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

  private

  def sort_column
    Article.column_names.include?(params[:sort]) ? params[:sort] : "published_at"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

end
