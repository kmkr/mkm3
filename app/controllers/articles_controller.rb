class ArticlesController < ApplicationController
  respond_to :json
  before_filter :authenticate_user!, :except => :index

  def index
    articles = Article.all.includes(:photos)

    respond_with articles
  end

  def show
    article = Article.includes(:photos).find(params[:id])

    respond_with article
  end

  def destroy
    article = Article.find(params[:id])

    article.destroy

    respond_with article
  end

  def update
    article = Article.find(params[:id])
    article.update_attributes(params[:article])
    respond_with article
  end

  def create
    article = Article.new(params[:article])
    article.save
    respond_with article
  end

end
