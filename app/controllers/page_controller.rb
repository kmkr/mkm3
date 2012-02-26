class PageController < ApplicationController

  def index
    @continents = Continent.order(:priority).includes(:countries)
    @continentz = Continent.all.to_json
    @countries = Country.all.to_json
    if user_signed_in?
      @articles = Article.all.to_json(:include => :photos)
    else
      @articles = Article.published.to_json(:include => :photos)
    end
  end
end
