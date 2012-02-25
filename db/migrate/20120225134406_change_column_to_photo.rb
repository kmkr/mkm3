class ChangeColumnToPhoto < ActiveRecord::Migration
  def change
    rename_column :photos, :useAsArticleImage, :useAsArticlePhoto
  end

end
