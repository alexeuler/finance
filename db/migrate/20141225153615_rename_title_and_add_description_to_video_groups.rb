class RenameTitleAndAddDescriptionToVideoGroups < ActiveRecord::Migration
  def self.up
    rename_column :video_groups,:value,:title
    add_column :video_groups, :description, :string
  end

  def self.down
    rename_column :video_groups,:title,:value
    remove_column :video_groups, :description
  end

end
