class AddAttachmentToBlogPosts < ActiveRecord::Migration
  def change
    add_column :blog_posts, :attachments, :string
  end
end
