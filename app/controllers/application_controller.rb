class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :load_data

  def load_data
    @continents = Continent.all
    @countries = Country.all
    if user_signed_in?
      @articles = Article.includes(:photos)
    else
      @articles = Article.published.includes(:photos)
    end
  end
end
