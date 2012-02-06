class CreateContinents < ActiveRecord::Migration
  def change
    create_table :continents do |t|
      t.string :title
      t.integer :priority

      t.timestamps
    end

    Continent.create(:title => 'America', :priority => 1)
    Continent.create(:title => 'Europe', :priority => 2)
    Continent.create(:title => 'Africa', :priority => 3)
    Continent.create(:title => 'Asia', :priority => 4)
    Continent.create(:title => 'Oceania', :priority => 5)
  end
end
