class Blog::Post < ActiveRecord::Base
  after_commit :update_tags

  private

  def update_tags
    Blog::Tag.update_all
  end

end
