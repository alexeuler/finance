class Video::Lesson < ActiveRecord::Base
  has_many :video_parts, :class_name => 'Video::Part'
  after_commit :update_tags

  private

  def update_tags
    Video::LessonTag.update_all
  end

end
