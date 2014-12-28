class CreateVideoLessons < ActiveRecord::Migration
  def change
    create_table :video_lessons do |t|
      t.string :title
      t.text :description
      t.string :image
      t.string :tags
      t.integer :order

      t.timestamps
    end
  end
end
