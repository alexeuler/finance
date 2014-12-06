class Blog::Post < ActiveRecord::Base
  after_commit :update_tags

  def update_tags
    Blog::Tag.update_all
  end
end
