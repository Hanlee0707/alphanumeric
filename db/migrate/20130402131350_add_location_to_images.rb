class AddLocationToImages < ActiveRecord::Migration
  def change
    add_column :images, :location, :integer
  end
end
