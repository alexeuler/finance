class ChangeBlogImage < ActiveRecord::Migration
  def self.up
    remove_column :blog_posts, :image
    add_attachment :blog_posts, :image
  end

  def self.down
    remove_attachment :blog_posts, :image
    add_column :blog_posts, :image, :string
  end

11end
