require_relative '../mixins/published'
class Blog::Post < ActiveRecord::Base
  paginates_per 7
  after_commit :update_tags
  extend Mixins::Published
  private

  def update_tags
    Blog::Tag.update_all
  end

end
