class SetDefaultLanguageToVideoLessons < ActiveRecord::Migration
  def self.up
    remove_column :video_lessons, :language
    add_column :video_lessons, :language, :string, default: 'ru', null: false
  end

  def self.down
    remove_column :video_lessons, :language
    add_column :video_lessons, :language, :string
  end

end
