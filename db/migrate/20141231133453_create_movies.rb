class CreateMovies < ActiveRecord::Migration
  def self.up
    create_table :movies do |t|
      t.string :tags

      t.timestamps
    end
    add_attachment :movies, :file
  end

  def self.down
    drop_table :movies
  end
end
