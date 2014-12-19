class ChangeExcerptAndRssTypesInBlogPosts < ActiveRecord::Migration
  def up
    change_column :blog_posts, :excerpt, :text
    change_column :blog_posts, :rss, :text
  end

  def down
    change_column :blog_posts, :excerpt, :string
    change_column :blog_posts, :rss, :string
  end
end
