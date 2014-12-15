class AddOrderToVideoGroup < ActiveRecord::Migration
  def change
    add_column :video_groups, :order, :integer
  end
end
