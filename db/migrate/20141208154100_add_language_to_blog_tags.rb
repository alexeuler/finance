class AddLanguageToBlogTags < ActiveRecord::Migration
  def change
    add_column :blog_tags, :language, :string, null:false, default:'ru'
  end
end
