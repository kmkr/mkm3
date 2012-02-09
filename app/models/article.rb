class Article < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader
  has_many :photos, :dependent => :destroy
end
