class ArticlesController < ApplicationController
  respond_to :json
  respond_to :html, :only => :show
  before_filter :authenticate_user!, :except => :index

  def index
    articles = Article.all.includes(:photos)

    respond_with articles
  end

  def show
    article = Article.includes(:photos).find(params[:id])

    respond_to do |format|
      format.json { render :json => article }
      format.html { redirect_to "#articles/#{article.id}" }
    end
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
