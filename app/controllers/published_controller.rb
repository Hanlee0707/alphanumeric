class PublishedController < ApplicationController
  before_filter :logged_in?

  layout :select_layout
  def select_layout
    if params[:editor_id] and employee_privilege("Editor") then
      'editor_layout'
    elsif params[:contributor_id] and employee_privilege("Contributor") then
      'contributor_layout'
    else
      'published_layout'
    end
  end  

  def index
    @isEditor = false
    @isContributor = false
    if params[:editor_id] and current_employee.id.to_s == params[:editor_id]
      @isEditor = true
      @articles = Article.where("status = ?", "Published").paginate page: params[:page], order: 'created_at desc', per_page: 20
    elsif params[:contributor_id] and current_employee.id.to_s == params[:contributor_id]
      @isContributor = true
      @articles = Article.where("contributor_id=? and status = ?", params[:contributor_id], "Published").paginate page: params[:page], order: 'created_at desc', per_page: 20
    else
      if params[:tag] then
        @articles = Article.tagged_with(params[:tag]).where("status = ?", "Published").paginate page: params[:page], order: 'created_at desc', per_page: 20
      else
        @articles = Article.where("status = ?", "Published").paginate page: params[:page], order: 'created_at desc', per_page: 20
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
      objects.append(object)
    }
    respond_to do |format| 
      format.html 
      format.json { render json: objects }
    end
  end

end
