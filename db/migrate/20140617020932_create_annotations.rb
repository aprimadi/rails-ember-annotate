class CreateAnnotations < ActiveRecord::Migration
  def change
    create_table :annotations do |t|
      t.integer :image_id
      t.text    :text
      t.float   :top
      t.float   :left
      t.integer :font_size
      t.timestamps
    end
  end
end
