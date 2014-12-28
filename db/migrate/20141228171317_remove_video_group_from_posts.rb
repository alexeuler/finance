class RemoveVideoGroupFromPosts < ActiveRecord::Migration
  def self.up
    remove_column :blog_posts, :video_group_id
  end

  def self.down
    add_column :blog_posts, :video_group_id, :integer
  end

end
