class AdditionalText < ActiveRecord::Base
  attr_accessible :article_id, :bullet, :location
  belongs_to :article
  validates_presence_of :bullet
end
