class ExtraInformation < ActiveRecord::Base
  attr_accessible :article_id, :explanation, :phrase
  belongs_to :article
end
