class CreateVideoLessonTags < ActiveRecord::Migration
  def change
    create_table :video_lesson_tags do |t|
      t.string :value
      t.string :language
      t.timestamps
    end
  end
end
