class CreateImageTags < ActiveRecord::Migration
  def change
    create_table :image_tags do |t|
      t.string :value

      t.timestamps
    end
  end
end
