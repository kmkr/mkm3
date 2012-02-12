class PhotosController < ApplicationController
  respond_to :json
  before_filter :authenticate_user!, :except => :index

  def create
    article = Article.find(params[:article_id], :include => :photos)    

    photo = Photo.new(:article_id => article.id, :position => article.photos.size + 1)

    file = read_file(params[:file_name], params[:binary_data])
    photo.photo = file
    photo.save!
     
    respond_with article, photo
  end

  private

  def read_file(fileName, binary)
    binary = Base64.decode64 params[:binary_data]
    tmpFileName = "#{Rails.root}/tmp/#{fileName}"
    File.open(tmpFileName, 'wb') { |f| f.write(binary) }
    File.open(tmpFileName, 'r')
  end
end
