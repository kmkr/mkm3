class PageController < ApplicationController
  def index
    @continents = Continent.order(:priority).includes(:countries)
  end
end
