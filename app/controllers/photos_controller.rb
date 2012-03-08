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


  # TODO: clean this up
  def update
    photo = Photo.find(params[:id])

    needRecreate = false

    if photo.isCropped and params[:crop_x]
      needRecreate = true
    end

    if params[:crop_x]
      if photo.crop_x != params[:crop_x] or photo.crop_y != params[:crop_y] or photo.crop_h != params[:crop_h] or photo.crop_w != params[:crop_w]
        needRecreate = true
      end
    end

    photo.update_attributes({ :caption => params[:caption], :crop_h => params[:crop_h], :crop_y => params[:crop_y], :crop_x => params[:crop_x], :crop_w => params[:crop_w], :position => params[:position], :useAsArticlePhoto => params[:useAsArticlePhoto], :useAsFrontpagePhoto => params[:useAsFrontpagePhoto], :widescreenCaption => params[:widescreenCaption]})


    photo.photo.recreate_versions! if needRecreate

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
