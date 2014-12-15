class AddVideoGroupIdToBlogPosts < ActiveRecord::Migration
  def change
    add_column :blog_posts, :video_group_id, :integer
  end
end
