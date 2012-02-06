class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.integer :country_id
      t.date :start_date
      t.date :end_date
      t.datetime :published
      t.float :latitude
      t.float :longitude
      t.int :zoom_level

      t.timestamps
    end
  end
end
