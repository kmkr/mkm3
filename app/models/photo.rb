class Photo < ActiveRecord::Base
  belongs_to :article
  attr_accessible :caption, :created_at, :crop_h, :crop_w, :crop_x, :crop_y, :position, :useAsArticlePhoto, :useAsFrontpagePhoto, :widescreenCaption
  mount_uploader :photo, PhotoUploader

  def isCropped
    self.crop_x
  end
end
