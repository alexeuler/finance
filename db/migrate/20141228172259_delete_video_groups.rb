class DeleteVideoGroups < ActiveRecord::Migration
  def self.up
    drop_table :video_groups
  end

  def self.down
    create_table "video_groups", force: true do |t|
      t.string "title"
      t.string "tags"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string "language"
      t.integer "order"
      t.text "description"
      t.string "image"
    end
  end
end
