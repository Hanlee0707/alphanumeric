class Image < ActiveRecord::Base
  attr_accessible :article_id, :image_name, :image_type, :location
  belongs_to :article
  mount_uploader :image_name, ImageUploader
end
