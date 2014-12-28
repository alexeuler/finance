class AddOrderToBlogPost < ActiveRecord::Migration
  def change
    add_column :blog_posts, :order, :integer
  end
end
