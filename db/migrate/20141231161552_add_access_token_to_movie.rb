class AddAccessTokenToMovie < ActiveRecord::Migration
  def change
    add_column :movies, :access_token, :string
  end
end
