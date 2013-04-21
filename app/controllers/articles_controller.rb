class ArticlesController < ApplicationController
  before_filter :logged_in?
  helper_method :sort_column, :sort_direction
  autocomplete :tag, :name, :full=> true, :class_name => 'ActsAsTaggableOn::Tag'
  autocomplete :contributor, :last_name, :class_name => 'Employee', :display_value => :full_name_with_email, :extra_data => [:first_name, :email], :scopes => [:contributor_only]
  before_filter :set_attribute
  def set_attribute
    if params[:editor_id] and employee_privilege("Editor") then
      @editor_layout = true
    elsif params[:contributor_id] and employee_privilege("Contributor") then
      @contributor_layout = true
    elsif request.path.include?("published")
      @published_layout = true
    elsif request.path.include?("archived")
      @archived_layout = true
    elsif request.path.include?("history/editor")
      @history_editor_layout = true
    elsif request.path.include?("history/contributor")
      @history_contributor_layout = true
    end
  end

  # GET /articles
  # GET /articles.json
  def index
#    @articles = Article.all
    @articles = Article.paginate page: params[:page], order: 'created_at desc', per_page: 20

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = Article.find(params[:id])
    @status = @article.status
    @show_edit = false
    @through_editor = false
    @through_contributor = false
    if params[:editor_id] then
      if current_employee and params[:editor_id] == current_employee.id.to_s
        @through_editor = true
        @through_contributor = false
        if @status == "Being Written" or @status == "Assigned" or @status == "Revoked" then
          @back_path = editor_incomplete_index_path(current_employee)
        elsif @status == "Need Review" then
          @show_edit = true
          @back_path = editor_review_index_path(current_employee)
          @edit_path = edit_editor_article_path(current_employee, @article)
        elsif @status == "Approved" then
          @back_path = editor_approved_index_path(current_employee)
        elsif @status == "Published" then
          @back_path = editor_published_index_path(current_employee)
        elsif @status == "Archived" then
          @back_path = history_editor_path
        end
        object = {:article => @article, :image =>@article.images, :numbers => @article.numbers, :extra_informations => @article.extra_informations, :additional_texts => @article.additional_texts, :citations => @article.citations}

        respond_to do |format|
          format.html # show.html.erb
          format.json { render json: object }
        end
      else
        respond_to do |format|
          format.html { redirect_to home_path, notice: "You can't view articles this way." }
          format.json { render json: object }
        end 
      end
    elsif params[:contributor_id] then
      @through_editor = false
      if params[:contributor_id] == current_employee.id.to_s
        @through_contributor = true
        if @status == "Being Written" or @status == "Assigned" or @status=="Revoked" then
          @show_edit = true
          @back_path = contributor_incomplete_index_path(current_employee)
          @edit_path = edit_contributor_article_path(current_employee, @article)
        elsif @status == "Need Review" then
          @back_path = contributor_review_index_path(current_employee)
        else
          @back_path = history_contributor_path
        end
        object = {:article => @article, :image =>@article.images, :numbers => @article.numbers, :extra_informations => @article.extra_informations, :additional_texts => @article.additional_texts, :citations => @article.citations}
        respond_to do |format|
          format.html # show.html.erb
          format.json { render json: object }
        end
      else
        respond_to do |format|
          format.html { redirect_to home_path, notice: "You can't view articles this way." }
          format.json { render json: object }
        end 
      end
    else
      if current_user then 
        @archived_article = current_user.archived_articles.find_by_article_id(@article.id)
      end
      if @history_editor_layout then
        @through_editor = true
      end
      if request.path.include?("published")
        @back_path = request.path.split("published")[0] + "published"
      elsif request.path.include?("archived")
        @back_path = request.path.split("archived")[0] + "archived"
      elsif request.path.include?("history/editor")
        @back_path = request.path.split("history/editor")[0] + "history/editor"
      elsif request.path.include?("history/contributor")
        @back_path = request.path.split("history/contributor")[0] + "history/contributor"
      end
    end
  end

  # GET /articles/new
  # GET /articles/new.json
  def new
    @current_employee = current_employee
    if !params[:editor_id] or params[:editor_id]!=@current_employee.id.to_s then
      respond_to do |format|
        format.html { redirect_to home_path, notice: "You don't have the required privilege." }
      end
    else
      @article = Article.new
      @back_path = editor_path(@current_employee)
      @editor_id = @current_employee.id
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @article }
      end
    end
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find(params[:id])
    @status = @article.status
    if params[:editor_id] then
      if current_employee and params[:editor_id] == current_employee.id.to_s
        if @status== "Need Review" then
          @back_path = editor_article_path(current_employee, @article)
          respond_to do |format|
            format.html 
            format.json { render json: object }
          end
        else
          respond_to do |format|
            format.html { redirect_to editor_article_path(current_employee, @article), notice: "You can't edit this article." }
          end
        end
      else
        respond_to do |format|
          format.html { redirect_to home_path, notice: "Invalid access." }
          format.json { render json: object }
        end 
      end
    elsif params[:contributor_id] then
      if params[:contributor_id] == current_employee.id.to_s
        @back_path = contributor_article_path(current_employee, @article)    
        if @status == "Assigned" then
          @article.update_attribute(:status, "Being Written")
          @article = Article.find(params[:id])
          respond_to do |format|
            format.html 
            format.json { render json: object }
          end
        elsif @status == "Being Written" or @status =="Revoked" then
          respond_to do |format|
            format.html 
            format.json { render json: object }
          end
        else 
          respond_to do |format|
            format.html { redirect_to contributor_article_path(current_employee, @article), notice: "You can't edit this article." }
          end
        end
      else
        respond_to do |format|
          format.html { redirect_to home_path, notice: "Invalid access." }
          format.json { render json: object }
        end 
      end
    end
  end

  # POST /articles
  # POST /articles.json
  def create
    params[:article][:status]= "Assigned"
    @article = Article.new(params[:article])
    respond_to do |format|
      if @article.save
        contributor = Employee.find(params[:article][:contributor_id])
        contributor.notify_new_article(params[:article][:title])
        format.html { redirect_to editor_article_url(current_employee, @article), notice: 'Article was successfully created.' }
        format.json { render json: @article, status: :created, location: @article }
    
      else
        @back_path = editor_path(@current_employee)
        @editor_id = @current_employee.id
        format.html { render action: "new" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  
  # PUT /articles/1
  # PUT /articles/1.json
  def update
    @article = Article.find(params[:id])
    respond_to do |format|
      if @article.update_attributes(params[:article])
        if params[:contributor_id] then
          format.html { redirect_to contributor_article_url(current_employee, @article), notice: "Article was successfully updated." }
        elsif params[:editor_id] then
          format.html { redirect_to editor_article_url(current_employee, @article), notice: "Article was successfully updated." }
        end
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
        contributor = Employee.find(@article.contributor_id)
        contributor.notify_delete_article(@article.title, params[:reason])
      format.html { redirect_to params[:back_path], notice: "Article was successfully deleted." }
      format.json { head :no_content }
    end
  end

  def publish_articles 
    @published_items = Article.where("editor_id=? and status = ?", params[:editor_id], "Approved")
    count = 0
    @published_items.each do |item|
      if !params[:"article_#{item.id}"].nil? 
contributor = Employee.find(item.contributor_id)
        contributor.notify_publish_article(item.title)
        item.update_attribute(:status, "Published")        
        count = count + 1
      end
    end
    respond_to do |format|
      format.html { redirect_to editor_approved_index_path(params[:editor_id]), notice: count.to_s + " articles were successfully published."}
    end
  end
  
  def archive_for_user
    if params[:archive]=="true" then
      @user_article = ArchivedArticle.new(:user_id => params[:user_id], :article_id => params[:article_id])
      if @user_article.save then
        notice = "Article was successfully archived."
      else
        notice = "Archiving failed."
      end
    else
      @user_article = User.find(params[:user_id]).archived_articles.find_by_article_id(params[:article_id])
      if @user_article.destroy then
        notice = "Article was successfully removed from the archive."
      else
        notice = "Removing from the archive failed."
      end
    end
      
    respond_to do |format|
      format.html { redirect_to published_article_path(params[:article_id]), notice: notice}
    end    
  end

  def archive_articles 
    @published_items = Article.where("status = ?", "Published")
    count = 0
    @published_items.each do |item|
      if !params[:"article_#{item.id}"].nil? 
        item.update_attribute(:status, "Archived")        
        count = count + 1
      end
    end
    respond_to do |format|
      format.html { redirect_to editor_published_index_path(params[:editor_id]), notice: count.to_s + " articles were successfully archived."}
    end
  end

  def update_status
    @article = Article.find(params[:id])
    update= true
    if (@article.title.nil? or @article.title=="") or (@article.city.nil? or @article.city=="") or (@article.current_content.nil? or @article.current_content=="") then
      update = false
    end
    if update then
      @article.update_attribute(:status, params[:status])
    end
    respond_to do |format|
      if params[:contributor_id] and params[:status]=="Need Review" then
        if update then
          editor = Employee.find(@article.editor_id)
          editor.notify_review_article(@article.title)
          notice = "Article was successfully submitted for review."
        else
          notice = "Article was not submitted for review because required fields are not filled out."
        end
        format.html { redirect_to contributor_article_path(params[:contributor_id], @article), notice: notice}
      elsif params[:editor_id] then
        if params[:status]=="Revoked" then
          if !update then
            @article.update_attribute(:status, params[:status])
          end
          contributor = Employee.find(@article.contributor_id)
          contributor.notify_revoke_article(@article.title, params[:reason])
          format.html { redirect_to editor_article_path(params[:editor_id], @article), notice: "Article was successfully revoked."}
        elsif params[:status]=="Approved" then
          if update then
            notice =  "Article was successfully approved."
          else
            notice = "Article was not approved because required fields are not filled out."
          end
          format.html { redirect_to editor_article_path(params[:editor_id], @article), notice: notice}
        elsif params[:status]=="Published" then
          format.html { redirect_to editor_article_path(params[:editor_id], @article), notice: "Article was successfully published."}
        end
      end
    end    
  end

  def search_articles
    if sort_column == "occurred" then
      @results = Article.search(params[:search]).order(sort_column+ " " + sort_direction+", occurred_time "+sort_direction).paginate(:per_page => 20, :page => params[:page])
    else
     @results = Article.search(params[:search]).order(sort_column+ " " + sort_direction).paginate(:per_page => 20, :page => params[:page])
    end

    respond_to do |format|
      format.js
    end
  end

  def add_to_the_article
    @article_id = params[:article_id]
    @article_content = params[:article_content]
    @article_occurred = Article.find(@article_id).occurred
    respond_to do |format|
      format.js
    end
  end

  def previous
    @article_id = params[:article_id]
    @article = Article.find(@article_id)
    respond_to do |format|
      format.js
    end
  end

  def recent
    @article_id = params[:article_id]
    @article = Article.find(@article_id)
    respond_to do |format|
      format.js
    end
  end

  def details
    @article_id = params[:article_id]
    @article = Article.find(@article_id)
    respond_to do |format|
      format.js
    end
  end

  def random
    @employees = Employee.contributor_only
    @employee = @employees.offset(rand(@employees.count)).first
    respond_to do |format|
      format.js
    end
  end

  private

  def sort_column
    Article.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
