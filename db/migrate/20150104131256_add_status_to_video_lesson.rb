class AddStatusToVideoLesson < ActiveRecord::Migration
  def change
    add_column :video_lessons, :status, :string
  end
end
