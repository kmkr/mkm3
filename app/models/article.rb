class Article < ActiveRecord::Base
  has_many :photos, :dependent => :destroy, :order => :position
  scope :published, where("published <= ?", Time.now.end_of_day)

  def is_published?
    self.published and self.published <= Time.now.end_of_day
  end

end
