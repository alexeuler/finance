class RenameExcerptToDescriptionInBlogPosts < ActiveRecord::Migration
  def change
    rename_column :blog_posts, :excerpt, :description
  end
end
