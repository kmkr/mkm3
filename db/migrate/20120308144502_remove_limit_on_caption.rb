class RemoveLimitOnCaption < ActiveRecord::Migration
  def change
    change_column :photos, :caption, :text, :limit => nil
  end

end
