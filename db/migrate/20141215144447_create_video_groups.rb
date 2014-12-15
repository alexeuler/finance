class CreateVideoGroups < ActiveRecord::Migration
  def change
    create_table :video_groups do |t|
      t.string :value
      t.string :tags

      t.timestamps
    end
  end
end
