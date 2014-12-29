class Video::Part < ActiveRecord::Base
  belongs_to :video_lesson, :class_name => 'Video::Lesson'

end
