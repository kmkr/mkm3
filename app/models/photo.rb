class Photo < ActiveRecord::Base
  belongs_to :article
  mount_uploader :photo, PhotoUploader
end
