require_relative '../mixins/published'
class Video::Lesson < ActiveRecord::Base
  has_many :video_parts, :class_name => 'Video::Part'
  after_commit :update_tags
  extend Mixins::Published

  private

  def update_tags
    Video::LessonTag.update_all
  end

end
