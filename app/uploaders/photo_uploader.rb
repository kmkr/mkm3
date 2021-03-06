# encoding: utf-8

class PhotoUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  #storage :file
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    Rails.logger.info "Trying to store #{model.inspect}"
    "uploads/#{model.class.to_s.underscore}s/article_#{model.article.id}/#{model.id}"
  end

  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  process :auto_orient
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  #version :thumbnail do
  #  process :resize_to_limit => [170, 170]
  #end

  version :small do
    process :resize_to_fit => [250, 5000] # requires two args
  end

  version :medium do
    process :resize_to_limit => [450, 450]
  end

  version :large do
    process :resize_to_limit => [1400, 1400]
  end
  
  version :cropped, :if => :is_cropped? do
    process :crop_photo
    process :resize_to_limit => [968, 400]
  end
  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  protected
  def auto_orient
    manipulate! do |img|
      img.auto_orient
    end
  end

  def crop_photo
    manipulate! do |img|
      img.crop(model.crop_x, model.crop_y, model.crop_w, model.crop_h)
    end
  end

  def is_cropped?(file)
    !model.crop_x.blank?
  end

end
