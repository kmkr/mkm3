class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :title
      t.float :latitude
      t.float :longitude
      t.integer :zoom_level
      t.integer :continent_id

      t.timestamps
    end
  end
end
