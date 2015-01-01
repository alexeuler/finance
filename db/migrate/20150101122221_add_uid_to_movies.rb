class AddUidToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :uid, :string
  end
end
