class CreateVideoParts < ActiveRecord::Migration
  def change
    create_table :video_parts do |t|
      t.string :title
      t.text :description
      t.text :body
      t.text :tags
      t.string :status
      t.string :slug
      t.string :language
      t.integer :order

      t.timestamps
    end
  end
end
