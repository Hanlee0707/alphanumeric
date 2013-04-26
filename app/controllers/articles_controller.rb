class ArticlesController < ApplicationController
  before_filter :logged_in?
  before_filter :has_privilege?
  helper_method :sort_column, :sort_direction
  autocomplete :tag, :name, :full=> true, :class_name => 'ActsAsTaggableOn::Tag'
  autocomplete :contributor, :last_name, :class_name => 'Employee', :display_value => :full_name_with_email, :extra_data => [:first_name, :email], :scopes => [:contributor_only]
  autocomplete :issue, :name, :full=> true, :class_name => 'ActsAsTaggableOn::Tag', :scopes => [:issues]

  before_filter :set_attribute
  def set_attribute
    if request.path.include?("editor") then
      @editor_layout = true
    elsif request.path.include?("contributor") then
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
    object = {:article => @article, :image =>@article.images, :numbers => @article.numbers, :extra_informations => @article.extra_informations, :additional_texts => @article.additional_texts, :citations => @article.citations, :tag_list => @article.tag_list, :issue_list => @article.issue_list}
    if current_user then 
      if current_user.user_read_articles.find_by_article_id(params[:id]).nil? 
        UserReadArticle.create(:user_id => current_user.id, :article_id => params[:id])
      end
    end
    if current_employee then
      if request.path.include?("editor") then
        if @article.editor_id == current_employee.id then
          @edit_path = edit_editor_article_path(@article)
          if @status == "Being Written" or @status == "Assigned" or @status == "Revoked" then
            @back_path = editor_incomplete_index_path
          else
            @show_edit = true
            if @status == "Need Review" then
              @back_path = editor_review_index_path
            elsif @status == "Approved" then
              @back_path = editor_approved_index_path
            elsif @status == "Published" then
              @back_path = editor_published_index_path
            elsif @status == "Archived" then
              @back_path = history_editor_path
            end
          end
          if flash[:back_path] then
            @back_path = flash[:back_path]
          end
          respond_to do |format|
            format.html # show.html.erb
            format.json { render json: object }
          end
        else
          if @status=="Published" then
            @back_path = editor_published_index_path
            if flash[:back_path] then
              @back_path = flash[:back_path]
            end
          else
            respond_to do |format|
              format.html { redirect_to home_path, notice: "You can't view other editors' unpublished articles." and return }
            end
          end
        end
      elsif request.path.include?("contributor")
        if @article.contributor_id == current_employee.id
          if @status == "Being Written" or @status == "Assigned" or @status=="Revoked" then
            @show_edit = true
            @back_path = contributor_incomplete_index_path
            @edit_path = edit_contributor_article_path(@article)
          elsif @status == "Need Review" then
            @back_path = contributor_review_index_path
          else
            @back_path = history_contributor_path
          end
          if flash[:back_path] then
            @back_path = flash[:back_path]
          end
          respond_to do |format|
            format.html # show.html.erb
            format.json { render json: object }
          end
        else
          respond_to do |format|
            format.html { redirect_to home_path, notice: "You can't view other contributors' articles." and return }
            format.json { render json: object }
          end 
        end
      elsif request.path.include?("published") then
        @back_path = published_index_path
        if flash[:back_path] then
          @back_path = flash[:back_path]
        end
      end
    elsif current_user then 
      @user_archived_article = current_user.user_archived_articles.find_by_article_id(@article.id)
    end
  end

  # GET /articles/new
  # GET /articles/new.json
  def new
    if request.path.include?("editor") then
      @article = Article.new
      @back_path = editor_path
      @editor_id = current_employee.id
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @article }
      end
    else
      respond_to do |format|
        format.html { redirect_to home_path, notice: "You don't have the required privilege." and return}
      end
    end
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find(params[:id])
    @status = @article.status
    if request.path.include?("editor") then
      if current_employee.id == @article.editor_id
        if @status!= "Assigned" and @status!="Being Written" then
          @back_path = editor_article_path(@article)
          respond_to do |format|
            format.html 
          end
        else
          respond_to do |format|
            format.html { redirect_to editor_article_path(@article), notice: "You can't edit this article yet." and return }
          end
        end
      else
        respond_to do |format|
          format.html { redirect_to home_path, notice: "You can't edit other editors' articles." and return}
        end 
      end
    elsif request.path.include?("contributor") then
      if current_employee.id = @article.contributor_id then
        @back_path = contributor_article_path(@article)    
        if @status == "Assigned" then
          @article.update_attribute(:status, "Being Written")
          @article = Article.find(params[:id])
          respond_to do |format|
            format.html 
          end
        elsif @status == "Being Written" or @status =="Revoked" then
          respond_to do |format|
            format.html 
          end
        else 
          respond_to do |format|
            format.html { redirect_to contributor_article_path(@article), notice: "You can't edit this article." and return}
          end
        end
      else
        respond_to do |format|
          format.html { redirect_to home_path, notice: "You can't editor other contributors' articles." and return }
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
        format.html { redirect_to editor_article_url(@article), notice: 'Article was successfully created.' and return }
        format.json { render json: @article, status: :created, location: @article }    
      else
        begin
          if params[:article][:contributor_id] then
            @assigned_contributor = Employee.find(params[:article][:contributor_id])
            @assigned_contributor_name = @assigned_contributor.first_name + " "+ @assigned_contributor.last_name+" ("+@assigned_contributor.email+")"
          end  
        rescue ActiveRecord::RecordNotFound
        end
        @back_path = editor_path
        @editor_id = @current_employee.id
        format.html { render action: "new" and return }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  
  # PUT /articles/1
  # PUT /articles/1.json
  def update
    @article = Article.find(params[:id])
    if current_employee and (current_employee.id == @article.editor_id or current_employee.id == @article.contributor_id)
      respond_to do |format|
        if @article.update_attributes(params[:article])
          if request.path.include? "contributor" then
            format.html { redirect_to contributor_article_url(@article), notice: "Article was successfully updated." and return}
          elsif request.path.include? "editor" then
            format.html { redirect_to editor_article_url(@article), notice: "Article was successfully updated." and return }
          end
          format.json { head :no_content }
        else
          if request.path.include? "editor" then
            @back_path = editor_article_path(@article)
          elsif request.path.include? "contributor" then
            @back_path = contributor_article_path(@article)  
          end
          format.html { render action: "edit" and return}
          format.json { render json: @article.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format| 
        format.html { redirect_to home_path, notice: "You can't access this page." and return}
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      begin
        contributor = Employee.find(@article.contributor_id)
        contributor.notify_delete_article(@article.title, params[:reason])
      rescue ActiveRecord::RecordNotFound
      end
      format.html { redirect_to params[:back_path], notice: "Article was successfully deleted." and return }
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
        item.update_attribute(:published_at, Time.now)
        count = count + 1
      end
    end
    respond_to do |format|
      format.html { redirect_to editor_approved_index_path, notice: count.to_s + " articles were successfully published." and return}
    end
  end
  
  def archive_for_user
    if params[:archive]=="true" then
      @user_article = UserArchivedArticle.new(:user_id => params[:user_id], :article_id => params[:article_id])
      if @user_article.save then
        notice = "Article was successfully archived."
      else
        notice = "Archiving failed."
      end
    else
      @user_article = User.find(params[:user_id]).user_archived_articles.find_by_article_id(params[:article_id])
      if @user_article.destroy then
        notice = "Article was successfully removed from the archive."
      else
        notice = "Removing from the archive failed."
      end
    end
      
    respond_to do |format|
      format.html { redirect_to user_published_article_path(params[:article_id]), notice: notice and return}
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
      format.html { redirect_to editor_published_index_path, notice: count.to_s + " articles were successfully archived." and return}
    end
  end

  def update_status
    @article = Article.find(params[:id])
    @update= true
    if (@article.title.nil? or @article.title=="") or (@article.city.nil? or @article.city=="") or (@article.current_content.nil? or @article.current_content=="") then
      @update = false
    end
    if @update then
      @article.update_attribute(:status, params[:status])
    end
    if request.env['HTTP_REFERER'].include? "contributor" then
      if params[:status]=="Need Review" then
        if @update then
          editor = Employee.find(@article.editor_id)
          editor.notify_review_article(@article.title)
          @status = "Need Review"
          @notice = "Article was successfully submitted for review."
        else
          @notice = "Article was not submitted for review because required fields are not filled out."
        end
        respond_to do |format|
          format.html { redirect_to contributor_article_url(@article), notice: @notice, flash: {:back_path => params[:back_path]} and return}
        end
      end
    elsif request.env['HTTP_REFERER'].include? "editor" then
      if params[:status]=="Revoked" then
        if !@update then
          @article.update_attribute(:status, params[:status])
        end
        contributor = Employee.find(@article.contributor_id)
        contributor.notify_revoke_article(@article.title, params[:reason])
        @status = "Revoked"
        @notice= "Article was successfully revoked."
        @update= true
        respond_to do |format|
          format.html { redirect_to editor_article_url(@article), notice: @notice, flash: {:back_path => params[:back_path]} and return}
        end
      elsif params[:status]=="Approved" then
        if @update then
          @notice =  "Article was successfully approved."
        else
          @notice = "Article was not approved because required fields are not filled out."
        end
        @status = "Approved"
        respond_to do |format|
          format.html { redirect_to editor_article_url(@article), notice: @notice, flash: {:back_path => params[:back_path]} and return}
        end
      elsif params[:status]=="Published" then
        if @update then
          @article.update_attribute(:published_at, Time.now)
          @status = "Published"
          @notice = "Article was successfully published."
        else
          @notice = "Article was not published. Check if all required fields were filled out."
        end
        respond_to do |format|
          format.html { redirect_to editor_article_url(@article), notice: @notice, flash: {:back_path => params[:back_path]} and return}
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

  def user_action
    if current_user then 
      if params[:user_action] == "archive" then
        for key, value in params do
          if key.include? "article_" and value=="0" then
            article_id = key.split("article_")[1]
            UserArchivedArticle.create(:user_id => current_user.id, :article_id => article_id)
          end
        end
        respond_to do |format|
          format.html {redirect_to user_published_index_url, notice: "Unselected articles were successfully archived."}
        end
      elsif params[:user_action] == "unarchive" then 
        for key, value in params do
          if key.include? "article_" and value=="1" then
            article_id = key.split("article_")[1]
            current_user.user_archived_articles.find_by_article_id(article_id).destroy
          end
        end
        respond_to do |format|
          format.html {redirect_to user_archived_index_url, notice: "Selected articles were successfully unarchived."}
        end
      elsif params[:user_action] == "playlist" then
        for key, value in params do
          if key.include? "article_" and value=="1" then
            article_id = key.split("article_")[1]
            current_user.user_archived_articles.find_by_article_id(article_id).destroy
          end
        end
        respond_to do |format|
          format.html {redirect_to user_archived_index_url, notice: "Selected articles were successfully unarchived."}
        end
      end
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
