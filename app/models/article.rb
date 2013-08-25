class Article < ActiveRecord::Base
  has_many :photos, :dependent => :destroy, :order => :position
  scope :published, where("published <= ?", Time.now.end_of_day)
  attr_accessible :country_id, :end_date, :latitude, :longitude, :body, :start_date, :title, :zoom_level

  def is_published?
    self.published and self.published <= Time.now.end_of_day
  end

  def as_json(options = {})
    options[:include] = :photos
    super(options)
  end

end
