class AddColumnsToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :widescreenCaption, :text

    add_column :photos, :useAsArticleImage, :boolean

  end
end
