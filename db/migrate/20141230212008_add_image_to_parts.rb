class AddImageToParts < ActiveRecord::Migration
  def change
    add_column :video_parts, :image, :string
  end
end
