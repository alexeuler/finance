class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images
    add_attachment :images, :file
  end


  def self.down
    drop_table :images
  end
end
