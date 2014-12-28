class AddLanguageToLesson < ActiveRecord::Migration
  def change
    add_column :video_lessons, :language, :string
  end
end
