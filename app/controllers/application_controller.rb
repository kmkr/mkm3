class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :load

  def load
    @continents = Continent.order(:priority).includes(:countries)
  end
end
