class ArticlesController < ApplicationController
  respond_to :json
  respond_to :html, :only => :show
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
    @article = Article.includes(:photos).find(params[:id])
    logger.warn("Inne i show Header: '#{request.env["HTTP_USER_AGENT"]}'")

    if @article.is_published? or user_signed_in
      respond_to do |format|
        format.json { render :json => @article }
        format.html {
          puts request.env["HTTP_USER_AGENT"]
          if request.env["HTTP_USER_AGENT"].match(/facebookexternalhit/)
            logger.warn "render show"
            render :show
          else
            logger.warn "render redirect"
            redirect_to "#articles/#{@article.id}"
          end
        }
      end
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
