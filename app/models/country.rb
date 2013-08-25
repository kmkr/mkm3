class Country < ActiveRecord::Base
  belongs_to :continent
  has_many :articles
  attr_accessible :title, :latitude, :longitude, :zoom_level, :continent_id
end
