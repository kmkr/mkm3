class ArticlesController < ApplicationController
  respond_to :html, :only => :show
  respond_to :json
  before_filter :authenticate_user!, :except => [ :index, :show ]

  def index
    if user_signed_in?
      articles = Article.all.includes(:photos)
    else
      articles = Article.published.includes(:photos)
    end

    respond_with articles
  end

  def show
    begin
      @article = Article.includes(:photos).find(params[:id])
      @title = @article.title
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Artikkelen du ba om finnes ikke."
      redirect_to root_path
      return
    end

    if @article.is_published? or user_signed_in?
      respond_with @article
    else
      flash[:notice] = "Artikkelen du ba om er ikke publisert."
      redirect_to root_path
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
