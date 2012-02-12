class Photo < ActiveRecord::Base
  attr_accessible :article_id, :caption, :position, :image
  belongs_to :article
  mount_uploader :photo, PhotoUploader
end
