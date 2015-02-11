class AddEntityIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :entity_id, :integer
  end
end
