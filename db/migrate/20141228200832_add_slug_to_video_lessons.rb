class AddSlugToVideoLessons < ActiveRecord::Migration
  def change
    add_column :video_lessons, :slug, :string
  end
end
