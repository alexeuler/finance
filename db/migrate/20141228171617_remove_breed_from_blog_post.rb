class RemoveBreedFromBlogPost < ActiveRecord::Migration
  def self.up
    remove_column :blog_posts, :breed
  end

  def self.down
    add_column :blog_posts, :breed, :string
  end

end
