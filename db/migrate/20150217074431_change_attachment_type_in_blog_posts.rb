class ChangeAttachmentTypeInBlogPosts < ActiveRecord::Migration
  def up
    change_column :blog_posts, :attachments, :text
  end

  def down
    change_column :blog_posts, :attachments, :string
  end
end
