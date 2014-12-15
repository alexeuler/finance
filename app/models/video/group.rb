class Video::Group < ActiveRecord::Base
  has_many :blog_posts, :class_name => 'Blog::Post'
end
