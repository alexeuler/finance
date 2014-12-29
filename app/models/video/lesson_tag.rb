require_relative '../mixins/tag'

class Video::LessonTag < ActiveRecord::Base
  extend Mixins::Tag
  def self.model
    Video::Lesson
  end
end
