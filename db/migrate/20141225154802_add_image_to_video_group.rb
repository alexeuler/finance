class AddImageToVideoGroup < ActiveRecord::Migration
  def change
    add_column :video_groups, :image, :string
  end
end
