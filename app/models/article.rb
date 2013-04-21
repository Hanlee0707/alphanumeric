class Article < ActiveRecord::Base
  attr_accessible :city, :country, :current_content, :title, :numbers_attributes, :images_attributes, :check, :id, :numbers, :images, :tag_list, :previous_summary, :contributor_id, :extra_informations_attributes, :additional_texts_attributes, :citations_attributes, :contributor_last_name, :status, :searched_contributor_id, :editor_id, :temporary_title, :instruction, :category
  attr_accessor :contributor_last_name, :searched_contributor_id

  validates_presence_of :instruction, :temporary_title, :contributor_id, :on=> :create
  has_many :numbers, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :extra_informations, dependent: :destroy
  has_many :additional_texts, dependent: :destroy
  has_many :citations, dependent: :destroy
  has_many :archived_articles, dependent: :destroy

  belongs_to :contributor, :class_name => "Employee", :foreign_key => "contributor_id"
  belongs_to :editor, :class_name => "Employee", :foreign_key => "editor_id"

  accepts_nested_attributes_for :numbers, allow_destroy: true
  accepts_nested_attributes_for :images, allow_destroy: true, reject_if: lambda { |a| a[:image_name].blank? || a[:image_type].blank? }
  accepts_nested_attributes_for :extra_informations, allow_destroy: true, reject_if: lambda { |a| a[:phrase].blank? || a[:explanation].blank? }
  accepts_nested_attributes_for :additional_texts, allow_destroy: true
  accepts_nested_attributes_for :citations, allow_destroy: true


  acts_as_taggable

  def previous_published(current_user=nil, path)
    if path.include?("published")
      if current_user then 
        intersection = Article.joins(current_user.archived_articles).select(:article_id). map { |tup| tup.article_id }
        Article.order("published_at asc").where(:status => "Published").where("id!=? and id not in (?) and published_at < ?", self.id, intersection, self.published_at).last
      else
        Article.order("published_at asc").where(:status => "Published").where("id!=? and published_at < ?", self.id, self.published_at).last
      end
    elsif path.include?("archived")
      if current_user then 
        intersection = Article.joins(current_user.archived_articles).select(:article_id). map { |tup| tup.article_id }
        Article.order("published_at asc").where("status = ? or status = ?", "Archived", "Published").where("id!=? and id in (?) and published_at < ?", self.id, intersection, self.published_at).last
      else
        Article.order("published_at asc").where("status = ?", "Archived").where("id!=? and published_at < ?", self.id, self.published_at).last
      end
    elsif path.include?("history/editor")
      Article.order("published_at asc").where("status = ?", "Archived").where("id!=? and published_at < ?", self.id, intersection, self.published_at).last      
    elsif path.include?("history/contributor")
      Article.order("published_at asc").where("status = ? or status = ? or status = ?", "Approved", "Published", "Archived").where("id!=? and published_at < ?", self.id, self.published_at).last      
    end
  end

  def next_published(current_user=nil, path)
    if path.include?("published")
      if current_user then 
        intersection = Article.joins(current_user.archived_articles).select(:article_id). map { |tup| tup.article_id }
      Article.order("published_at desc").where(:status => "Published").where("id!= ? and id not in (?) and published_at > ?", self.id, intersection, self.published_at).last
      else
      Article.order("published_at desc").where(:status => "Published").where("id!= ? and published_at > ?", self.id, self.published_at).last
      end
    elsif path.include?("archived")
      if current_user then 
        intersection = Article.joins(current_user.archived_articles).select(:article_id). map { |tup| tup.article_id }
        Article.order("published_at desc").where("status = ? or status = ?", "Archived", "Published").where("id!=? and id in (?) and published_at > ?", self.id, intersection, self.published_at).last
      else
        Article.order("published_at desc").where("status = ?", "Archived").where("id!=? and published_at > ?", self.id, self.published_at).last
      end
    elsif path.include?("history/editor")
      Article.order("published_at desc").where("status = ?", "Archived").where("id!=? and published_at > ?", self.id, intersection, self.published_at).last      
    elsif path.include?("history/contributor")
      Article.order("published_at desc").where("status = ? or status = ? or status = ?", "Approved", "Published", "Archived").where("id!=? and published_at > ?", self.id, self.published_at).last      
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
