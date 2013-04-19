class Article < ActiveRecord::Base
  attr_accessible :city, :country, :current_content, :title, :numbers_attributes, :images_attributes, :check, :id, :numbers, :images, :tag_list, :previous_summary, :contributor_id, :extra_informations_attributes, :additional_texts_attributes, :citations_attributes, :contributor_last_name, :status, :searched_contributor_id, :editor_id, :temporary_title, :instruction, :category
  attr_accessor :contributor_last_name, :searched_contributor_id

  validates_presence_of :instruction, :temporary_title, :contributor_id, :on=> :create
  validates :title, uniqueness: true

  has_many :numbers, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :extra_informations, dependent: :destroy
  has_many :additional_texts, dependent: :destroy
  has_many :citations, dependent: :destroy

  belongs_to :contributor, :class_name => "Employee", :foreign_key => "contributor_id"
  belongs_to :editor, :class_name => "Employee", :foreign_key => "editor_id"

  accepts_nested_attributes_for :numbers, allow_destroy: true
  accepts_nested_attributes_for :images, allow_destroy: true, reject_if: lambda { |a| a[:image_name].blank? || a[:image_type].blank? }
  accepts_nested_attributes_for :extra_informations, allow_destroy: true, reject_if: lambda { |a| a[:phrase].blank? || a[:explanation].blank? }
  accepts_nested_attributes_for :additional_texts, allow_destroy: true
  accepts_nested_attributes_for :citations, allow_destroy: true


  acts_as_taggable


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
