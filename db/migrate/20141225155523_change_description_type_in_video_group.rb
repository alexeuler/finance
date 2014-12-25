class ChangeDescriptionTypeInVideoGroup < ActiveRecord::Migration
  def self.up
    change_column :video_groups, :description, :text
  end

  def self.down
    change_column :video_groups, :description, :string
  end

end
