class Video::Lesson < ActiveRecord::Base
  after_commit :update_tags

  private

  def update_tags
    Video::LessonTag.update_all
  end

end
