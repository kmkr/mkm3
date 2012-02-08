class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :load

  def load
    @continents = Continent.order(:priority).includes(:countries)
    @continentz = Continent.all.to_json
    @countries = Country.all.to_json
    @articles = Article.all.to_json
  end
end
