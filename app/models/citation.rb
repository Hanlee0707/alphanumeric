class Citation < ActiveRecord::Base
  attr_accessible :article_id, :author, :link, :published_date, :publisher, :title, :accessed_date
  belongs_to :article

  validates_presence_of :author, :link, :published_date, :publisher, :title, :accessed_date

end
