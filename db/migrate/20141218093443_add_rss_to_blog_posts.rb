class AddRssToBlogPosts < ActiveRecord::Migration
  def change
    add_column :blog_posts, :rss, :string
  end
end
