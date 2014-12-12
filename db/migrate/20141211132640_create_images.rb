class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.string :tags
      t.string :access_token
      t.timestamps
    end
    add_attachment :images, :file
  end


  def self.down
    drop_table :images
  end
end
