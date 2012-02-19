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

  def destroy
    article = Article.find(params[:article_id], :include => :photos)
    photo = Photo.find(params[:id])
    photo.remove_photo!
    article.photos.delete(photo)

    respond_with photo
  end

  def update
    photo = Photo.find(params[:id])

    photo.crop_x = params[:crop_x]
    photo.crop_y = params[:crop_y]
    photo.crop_h = params[:crop_h]
    photo.crop_w = params[:crop_w]
    photo.save

    photo.photo.recreate_versions!

    respond_with photo
  end

  private

  def read_file(fileName, binary)
    binary = Base64.decode64 params[:binary_data]
    tmpFileName = "#{Rails.root}/tmp/#{fileName}"
    File.open(tmpFileName, 'wb') { |f| f.write(binary) }
    File.open(tmpFileName, 'r')
  end
end
