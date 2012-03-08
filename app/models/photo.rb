class Photo < ActiveRecord::Base
  belongs_to :article
  mount_uploader :photo, PhotoUploader

  def isCropped
    self.crop_x
  end
end
