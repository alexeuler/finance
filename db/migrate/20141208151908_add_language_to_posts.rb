class AddLanguageToPosts < ActiveRecord::Migration
  def change
    add_column :blog_posts, :language, :string, default: "ru", null: false
  end
end
