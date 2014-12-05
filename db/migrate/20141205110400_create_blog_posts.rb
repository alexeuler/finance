class CreateBlogPosts < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
      t.string :title
      t.text :body
      t.text :tags
      t.string :status
      t.string :image
      t.string :category
      t.text :excerpt
      t.string :slug

      t.timestamps
    end
  end
end
