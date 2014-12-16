class AddTypeAndRemoveImageToBlogPosts < ActiveRecord::Migration
  def self.up
    add_column :blog_posts, :breed, :string
    remove_columns :blog_posts, :image_file_name, :image_content_type,
                  :image_file_size, :image_updated_at
  end

  def self.down
    add_column :blog_posts, :image_file_name, :string
    add_column :blog_posts, :image_content_type, :string
    add_column :blog_posts, :image_file_size, :string
    add_column :blog_posts, :image_updated_at, :datetime
    remove_column :blog_posts, :breed, :string
  end


end
