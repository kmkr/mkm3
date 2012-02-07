class ArticlesController < ApplicationController
  respond_to :json
  before_filter :authenticate_user!, :except => :index

  def index
    articles = Article.all

    respond_with articles
  end

  def create
    article = Article.new(params[:article])
    article.save
    respond_with article
  end

end
