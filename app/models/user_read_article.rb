class UserReadArticle < ActiveRecord::Base
  attr_accessible :article_id, :user_id
end
