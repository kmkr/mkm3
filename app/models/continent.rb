class Continent < ActiveRecord::Base
  has_many :countries
  attr_accessible :title, :priority
end
