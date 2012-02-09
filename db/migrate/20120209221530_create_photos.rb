class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :article_id
      t.string :caption
      t.string :photo

      t.timestamps
    end
  end
end
