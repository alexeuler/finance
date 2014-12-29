class AddVideoLessonIdToVideoPart < ActiveRecord::Migration
  def change
    add_column :video_parts, :video_lesson_id, :integer
  end
end
