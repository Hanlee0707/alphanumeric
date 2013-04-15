class Number < ActiveRecord::Base
  attr_accessible :article_id, :value, :explanation
  belongs_to :article
  validates_presence_of :value, :explanation

end
