class ListController < ApplicationController
  before_filter :logged_in?
  helper_method :sort_column, :sort_direction


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
      @tag = params[:tag]
      @articles = Article.tagged_with(params[:tag]).where("status = ? OR status = ?", "Published", "Archived")
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




  # def index
  #   if params[:tag]
  #     @tag = params[:tag]
  #     @articles = Article.tagged_with(params[:tag]).where("status = ? OR status = ?", "Published", "Archived").paginate page: params[:page], order: 'published_at desc', per_page: 20
  #     objects = []
  #     objects = []
  #     @articles.map { |article| 
  #       object = {}
  #       object[:article]=article
  #       object[:image]=article.images
  #       object[:numbers]=article.numbers
  #       object[:extra_informations]=article.extra_informations
  #       object[:additional_texts]=article.additional_texts
  #       object[:tag_list]=article.tag_list
  #       object[:citations]=article.citations
  #       objects.append(object)
  #     }
  #     respond_to do |format| 
  #       format.html 
  #       format.json { render json: objects }
  #     end
  #   else
  #     @back_path = request.env["HTTP_REFERER"]
  #     respond_to do |format| 
  #       format.html {redirect_to @back_path, notice: "Wrong way to access this page." }
  #     end
  #   end
  # end
end
