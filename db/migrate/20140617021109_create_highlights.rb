class CreateHighlights < ActiveRecord::Migration
  def change
    create_table :highlights do |t|
      t.integer :image_id
      t.float :top
      t.float :left
      t.float :width
      t.float :height
      t.timestamps
    end
  end
end
