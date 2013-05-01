class ArticlesController < ApplicationController
  before_filter :logged_in?
  before_filter :has_privilege?
  helper_method :sort_column, :sort_direction
  autocomplete :tag, :name, :full=> true, :class_name => 'ActsAsTaggableOn::Tag'
  autocomplete :contributor, :last_name, :class_name => 'Employee', :display_value => :full_name_with_email, :extra_data => [:first_name, :email], :scopes => [:contributor_only]
  autocomplete :editor, :last_name, :class_name => 'Employee', :display_value => :full_name_with_email, :extra_data => [:first_name, :email], :scopes => [:editor_only]
  autocomplete :issue, :name, :full=> true, :class_name => 'ActsAsTaggableOn::Tag', :scopes => [:issues]

  before_filter :set_attribute
  def set_attribute
    if request.path.include?("workspace") then
      @workspace_layout = true
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
    @can_update = false
    @can_delete = false
    object = {:article => @article, :image =>@article.images, :numbers => @article.numbers, :extra_informations => @article.extra_informations, :additional_texts => @article.additional_texts, :citations => @article.citations, :tag_list => @article.tag_list, :issue_list => @article.issue_list}
    if current_user then 
      if current_user.user_read_articles.find_by_article_id(params[:id]).nil? 
        UserReadArticle.create(:user_id => current_user.id, :article_id => params[:id])
      end
    end
    if current_employee then
      if employee_privilege("Editor") then
        if @article.editor_id == current_employee.id or current_employee.employee_positions.find_by_position("Editor").level > 1 then
          @edit_path = edit_workspace_article_path(@article)
          if @article.contributor_id == current_employee.id then
            @can_delete = true
            @can_update = true
            @show_edit = true
          end
          if @status == "Being Written" or @status == "Assigned" or @status == "Revoked" then
            @back_path = incomplete_workspace_index_path
          else
            @can_delete = true
            @can_update = true
            @show_edit = true
            if @status == "Need Review" then
              @back_path = review_workspace_index_path
            elsif @status == "Approved" then
              @back_path = approved_workspace_index_path
            elsif @status == "Published" then
              @back_path = published_workspace_index_path
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
            @back_path = published_workspace_index_path
            if flash[:back_path] then
              @back_path = flash[:back_path]
            end
          else
            respond_to do |format|
              format.html { redirect_to home_path, notice: "You can't view other editors' unpublished articles." and return }
            end
          end
        end
      elsif employee_privilege("Contributor") then
        if @article.contributor_id == current_employee.id
          if @status == "Being Written" or @status == "Assigned" or @status=="Revoked" then
            if @article.initiated_by_contributor then
              @can_delete = true
            end
            @show_edit = true
            @can_update = true
            @back_path = incomplete_workspace_index_path
            @edit_path = edit_workspace_article_path(@article)
          elsif @status == "Need Review" then
            @back_path = review_workspace_index_path
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
      end
    elsif current_user then 
      @user_archived_article = current_user.user_archived_articles.find_by_article_id(@article.id)
    end
  end

  # GET /articles/new
  # GET /articles/new.json
  def new
    if employee_privilege("Editor") then
      if !request.path.include? "draft" and !request.path.include? "assign" then
        respond_to do |format|
          format.html { redirect_to home_path, notice: "Invalid Access." and return}
        end
      else
        if request.path.include? "assign" then
          @isAssign = true
        elsif request.path.include? "draft" then
          @isDraft = true
        end
        @isEditor = true
        @article = Article.new
        @back_path = home_path
        @editor_id = current_employee.id
        respond_to do |format|
          format.html # new.html.erb
        end
      end
    elsif employee_privilege("Contributor") then
      if !request.path.include? "draft" then
        respond_to do |format|
          format.html { redirect_to home_path, notice: "Invalid Access." and return}
        end
      else
        if request.path.include? "draft" then
          @isDraft = true
        end
        @isContributor = true
        @article = Article.new
        @back_path = home_path
        @contributor_id = current_employee.id
        respond_to do |format|
          format.html
        end
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
    @contributorInit = false
    if @article.initiated_by_contributor.nil?
      @article.update_attribute(:initiated_by_contributor, false)
    else
      if @article.initiated_by_contributor then
        @contributorInit = true
      end
    end
      
    if employee_privilege("Editor") then
      if current_employee.id == @article.editor_id or current_employee.employee_positions.find_by_position("Editor").level > 1 then
        if current_employee.id == @article.contributor_id then
          if @status== "Assigned" then
            @article.update_attribute(:status, "Being Written")
          end
        end
        @isEditor = true
        @back_path = workspace_article_path(@article)
        if !request.env['HTTP_REFERER'].include? "workspace" and request.env['HTTP_REFERER'].include? "published" then
          @back_path = published_index_path
        end
        respond_to do |format|
          format.html 
        end
      else
        respond_to do |format|
          format.html { redirect_to home_path, notice: "You can't edit other editors' articles." and return}
        end 
      end
    elsif employee_privilege("Contributor") then 
      if current_employee.id == @article.contributor_id then
        @isContributor = true
        @back_path = workspace_article_path(@article)    
        if @status == "Assigned" then
          @article.update_attribute(:status, "Being Written")
          respond_to do |format|
            format.html 
          end
        elsif @status == "Being Written" or @status =="Revoked" then
          respond_to do |format|
            format.html 
          end
        else 
          respond_to do |format|
            format.html { redirect_to workspace_article_path(@article), notice: "You can't edit this article." and return}
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
    if employee_privilege("Editor") or employee_privilege("Contributor") then
      if request.path.include? "assign" then
        params[:article][:status]= "Assigned"
      elsif request.path.include? "draft" then
        params[:article][:status]= "Being Written"
      end
      @article = Article.new(params[:article])
      respond_to do |format|
        if @article.save
          if request.path.include? "assign" then
            contributor = Employee.find(params[:article][:contributor_id])
            contributor.notify_new_article(params[:article][:temporary_title])
            @article.update_attribute(:initiated_by_contributor, false)
          elsif request.path.include? "draft" and !employee_privilege("Editor") then
            editor = Employee.find(params[:article][:editor_id])
            editor.notify_new_article_to_editor(params[:article][:temporary_title])
            @article.update_attribute(:initiated_by_contributor, true)
          end
          if request.path.include? "draft" and employee_privilege("Editor") then
            @article.update_attribute(:initiated_by_contributor, false)
            format.html { redirect_to edit_article_url(@article), notice: 'Article was successfully created.' and return }
          elsif request.path.include? "draft" and employee_privilege("Contributor") then
            format.html { redirect_to edit_article_url(@article), notice: 'Article was successfully created.' and return }
          elsif request.path.include? "assign" then
            format.html { redirect_to workspace_article_url(@article), notice: 'Article was successfully created.' and return }
          end
        else
          begin
            if request.path.include? "assign" then
              if params[:article][:contributor_id] then
                @assigned_contributor = Employee.find(params[:article][:contributor_id])
                @assigned_contributor_name = @assigned_contributor.first_name + " "+ @assigned_contributor.last_name+" ("+@assigned_contributor.email+")"
              end 
            elsif request.path.include? "draft" and !employee_privilege("Editor") then
              if params[:article][:editor_id] then
                @assigned_editor = Employee.find(params[:article][:editor_id])
                @assigned_editor_name = @assigned_editor.first_name + " "+ @assigned_editor.last_name+" ("+@assigned_editor.email+")"
              end 
            end
          rescue ActiveRecord::RecordNotFound
          end
          @back_path = home_path
          if request.path.include? "assign" then
            @isAssign = true
            @isEditor = true
            @editor_id = @current_employee.id
          elsif request.path.include? "draft" then
            @isDraft = true
            if employee_privilege("Editor") then
              @isEditor = true
              @editor_id = @current_employee.id
            elsif employee_privilege("Contributor") then
              @isContributor = true
              @contributor_id = @current_employee.id
            end
          end
          format.html { render action: "new" and return }
          format.json { render json: @article.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  
  # PUT /articles/1
  # PUT /articles/1.json
  def update
    @article = Article.find(params[:id])
    if current_employee and (current_employee.id == @article.editor_id or current_employee.id == @article.contributor_id)
      @article = Article.find(params[:id])
      respond_to do |format|
        if @article.update_attributes(params[:article])
            format.html { redirect_to workspace_article_url(@article), notice: "Article was successfully updated." and return}
        else
          @back_path = workspace_article_path(@article)
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
        if @article.contributor_id != current_employee.id then
          contributor = Employee.find(@article.contributor_id)
          contributor.notify_delete_article(@article.title, params[:reason])
        end
      rescue ActiveRecord::RecordNotFound
      end
      format.html { redirect_to params[:back_path], notice: "Article was successfully deleted." and return }
      format.json { head :no_content }
    end
  end

  def publish_articles 
    if employee_privilege("Editor") then
      @published_items = Article.where("editor_id=? and status = ?", params[:editor_id], "Approved")
      count = 0
      @published_items.each do |item|
        if !params[:"article_#{item.id}"].nil?  then
          contributor = Employee.find(item.contributor_id)
          if contributor.id != current_employee.id then
            contributor.notify_publish_article(item.title)
          end
          item.update_attribute(:status, "Published")        
          item.update_attribute(:published_at, Time.now)
          count = count + 1
        end
      end
      respond_to do |format|
        format.html { redirect_to approved_workspace_index_path, notice: count.to_s + " articles were successfully published." and return}
      end
    else
      respond_to do |format|
        format.html { redirect_to home_path, notice: "You can't publish articles." and return}
      end
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
    if employee_privilege("Editor") then
      @published_items = Article.where("status = ?", "Published")
      count = 0
      @published_items.each do |item|
        if !params[:"article_#{item.id}"].nil? 
        item.update_attribute(:status, "Archived")        
          count = count + 1
        end
      end
      respond_to do |format|
        format.html { redirect_to published_workspace_index_path, notice: count.to_s + " articles were successfully archived." and return}
      end
    else
      respond_to do |format|
        format.html { redirect_to home_path, notice: "You can't archive articles." and return}
      end
    end
  end

  def update_status
    if request.env['HTTP_REFERER'].include? "workspace" then
      @article = Article.find(params[:id])
      @update= true
      if (@article.title.nil? or @article.title=="") or (@article.city.nil? or @article.city=="") or (@article.current_content.nil? or @article.current_content=="") then
        @update = false
      end
      if @update then
        @article.update_attribute(:status, params[:status])
      end
      if employee_privilege("Editor") then
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
            format.html { redirect_to workspace_article_url(@article), notice: @notice, flash: {:back_path => params[:back_path]} and return}
          end
        elsif params[:status]=="Approved" then
          if @update then
            @notice =  "Article was successfully approved."
          else
            @notice = "Article was not approved because required fields are not filled out."
          end
          @status = "Approved"
          respond_to do |format|
            format.html { redirect_to workspace_article_url(@article), notice: @notice, flash: {:back_path => params[:back_path]} and return}
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
            format.html { redirect_to workspace_article_url(@article), notice: @notice, flash: {:back_path => params[:back_path]} and return}
          end
        end
      elsif employee_privilege("Contributor") then
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
            format.html { redirect_to workspace_article_url(@article), notice: @notice, flash: {:back_path => params[:back_path]} and return}
          end
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
    @isContributor = false
    @isEditor = false
    if request.env['HTTP_REFERER'].include? "editor" then
      @employees = Employee.contributor_only
      @employee = @employees.offset(rand(@employees.count)).first
      @isContributor = true
      respond_to do |format|
        format.js
      end
    elsif request.env['HTTP_REFERER'].include? "contributor" then
      @employees = Employee.editor_only
      @employee = @employees.offset(rand(@employees.count)).first
      @isEditor = true
      respond_to do |format|
        format.js
      end
    else
    end
  end

  def insert_article 
    article_id = params[:id] 
    if current_user then 
      if current_user.user_read_articles.find_by_article_id(params[:id]).nil? 
        UserReadArticle.create(:user_id => current_user.id, :article_id => article_id)
      end
    end
    begin
      @article = Article.find(article_id)
      respond_to do |format|
        format.js
      end
    rescue ActiveRecord::RecordNotFound
    
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
