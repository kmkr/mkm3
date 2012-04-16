class SitemapController < ApplicationController

  def show
    @articles = Article.published
  end
end
