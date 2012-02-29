class Article < ActiveRecord::Base
  has_many :photos, :dependent => :destroy, :order => :position
  scope :published, where("published <= ?", Time.now.end_of_day)

  def is_published?
    self.published <= Time.now.end_of_day
  end

  def as_json(options = {})
    super(:include => :photos)
  end

end
