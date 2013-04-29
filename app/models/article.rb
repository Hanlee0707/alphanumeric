class Article < ActiveRecord::Base
  attr_accessible :city, :country, :current_content, :title, :numbers_attributes, :images_attributes, :check, :id, :numbers, :images, :tag_list, :previous_summary, :contributor_id, :extra_informations_attributes, :additional_texts_attributes, :citations_attributes, :contributor_last_name, :status, :searched_contributor_id, :editor_id, :temporary_title, :instruction, :category, :issue_list, :searched_editor_id, :editor_last_name
  attr_accessor :contributor_last_name, :editor_last_name, :searched_contributor_id, :searched_editor_id

  validates_presence_of :instruction, :message => "^Please explain how the article will/should be written.", :on=> :create
  validates_presence_of :temporary_title, :message => "^Please give the article a temporary title.", :on=> :create
  validates_presence_of :contributor_id, :message => "^Please choose a contributor for the article. (You must press the Set button.)", :on=> :create
  validates_presence_of :editor_id, :message => "^Please choose an editor for the article. (You must press the Set button.)", :on=> :create
  validates_presence_of :issue_list, :message => "^Please enter an issue tag for this article. (You must press the Set button.)", :on=> :create
  has_many :numbers, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :extra_informations, dependent: :destroy
  has_many :additional_texts, dependent: :destroy
  has_many :citations, dependent: :destroy
  has_many :user_archived_articles, dependent: :destroy
  has_many :user_read_articles, dependent: :destroy

  belongs_to :contributor, :class_name => "Employee", :foreign_key => "contributor_id"
  belongs_to :editor, :class_name => "Employee", :foreign_key => "editor_id"

  accepts_nested_attributes_for :numbers, allow_destroy: true
  accepts_nested_attributes_for :images, allow_destroy: true, reject_if: lambda { |a| a[:image_name].blank? || a[:image_type].blank? }
  accepts_nested_attributes_for :extra_informations, allow_destroy: true, reject_if: lambda { |a| a[:phrase].blank? || a[:explanation].blank? }
  accepts_nested_attributes_for :additional_texts, allow_destroy: true
  accepts_nested_attributes_for :citations, allow_destroy: true

  acts_as_taggable
  acts_as_taggable_on :issues




  def previous_published(current_employee=nil, current_user=nil, path)
    if path.include?("published")
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
        currentIndex = @articles.index(self)
        if currentIndex <= 0 then
          return nil
        else
          @articles[currentIndex-1]
        end
      else
        @articles = Article.where("status = ?", "Published").order('published_at desc, created_at desc')
        currentIndex = @articles.index(self)
        if currentIndex <= 0 then
          return nil
        else
          @articles[currentIndex-1]
        end
      end
    elsif path.include?("archived")
      if current_user then
        @articles = Article.joins(:user_archived_articles).where("user_id = ?", current_user.id).order('published_at desc, created_at desc')
        currentIndex = @articles.index(self)
        if currentIndex <= 0 then
          return nil
        else
          @articles[currentIndex-1]
        end
      else
        return nil
      end
    elsif path.include?("history/editor")
      @articles = Article.where("editor_id=? and status =?", current_employee.id, "Archived").order("published_at desc, created_at desc")
      currentIndex = @articles.index(self)
      if currentIndex <= 0 then
        return nil 
      else
        @articles[currentIndex-1]
      end
    elsif path.include?("history/contributor")
      @articles = Article.where("contributor_id=? and (status = ? or status = ? or status = ?)", current_employee.id, "Approved", "Published", "Archived").order('published_at desc, created_at desc')
      currentIndex = @articles.index(self)
      if currentIndex <= 0 then
        return nil
      else
        @articles[currentIndex-1]
      end
    end
  end

  def next_published(current_employee=nil, current_user=nil, path)
    if path.include?("published")
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
        currentIndex = @articles.index(self)
        if currentIndex >= @articles.size-1 then
          return nil
        else
          @articles[currentIndex+1]
        end
      else
        @articles = Article.where("status = ?", "Published").order('published_at desc, created_at desc')
        currentIndex = @articles.index(self)
        if currentIndex >= @articles.size-1 then
          return nil
        else
          @articles[currentIndex+1]
        end
      end
    elsif path.include?("archived")
      if current_user then 
        @articles = Article.joins(:user_archived_articles).where("user_id = ?", current_user.id).order('published_at desc, created_at desc')
        currentIndex = @articles.index(self)
        if currentIndex >= @articles.size-1 then
          return nil
        else
          @articles[currentIndex+1]
        end
      else
        return nil
      end
    elsif path.include?("history/editor")
      @articles = Article.where("editor_id=? and status =?", current_employee.id, "Archived").order("published_at desc, created_at desc")
      currentIndex = @articles.index(self)
      if currentIndex >= @articles.size-1 then
        return nil 
      else
        @articles[currentIndex+1]
      end
    elsif path.include?("history/contributor")
      @articles = Article.where("contributor_id=? and (status = ? or status = ? or status = ?)", current_employee.id, "Approved", "Published", "Archived").order('published_at desc, created_at desc')
      currentIndex = @articles.index(self)
      if currentIndex >= @articles.size-1 then
        return nil
      else
        @articles[currentIndex+1]
      end
    end
  end

  def self.search(search)#, type)
    if search then #and type then
  #    search_keys = search.split(' ')
  #    search_keys.map { |key| key.gsub(/[^0-9A-Za-z]/,'')}
  #    if type=="tag" then
  #      self.tagged_with(search_keys, match_all: true)
  #    else
  #      search_string = []
  #      search_keys.each { |key|
  #        search_string.append("title LIKE ")
  #        search_string.append(" #{key} ")
  #        search_string.append("AND ")
  #      }
  #      search_string = search_string[0..search_string.length-2].join('')
  #      where(search_string)
      where('title LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
    
end
