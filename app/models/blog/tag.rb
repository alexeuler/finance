require_relative '../mixins/tag'

class Blog::Tag < ActiveRecord::Base
  extend Mixins::Tag
  def self.model
    Blog::Post
  end
end
