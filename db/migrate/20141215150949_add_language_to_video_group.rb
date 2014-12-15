class AddLanguageToVideoGroup < ActiveRecord::Migration
  def change
    add_column :video_groups, :language, :string
  end
end
