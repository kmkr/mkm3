class Photo < ActiveRecord::Base
  belongs_to :article
  attr_accessible :article_id, :position
  mount_uploader :photo, PhotoUploader

  def isCropped
    self.crop_x
  end
end
