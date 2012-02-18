class Article < ActiveRecord::Base
  has_many :photos, :dependent => :destroy

  def as_json(options = {})
    super(:include => :photos)
  end
end
