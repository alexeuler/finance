class Blog::Post < ActiveRecord::Base
  after_commit :update_tags
  after_initialize :default_values
  belongs_to :video_group, :class_name => 'Video::Group'

  scope :video, -> { where(breed: 'video') }
  scope :text, -> { where(breed: 'text') }

  private

  def update_tags
    Blog::Tag.update_all
  end

  def default_values
    self.breed ||= 'text'
  end

end
