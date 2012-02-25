class AddFrontpageColumnToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :useAsFrontpagePhoto, :boolean

  end
end
