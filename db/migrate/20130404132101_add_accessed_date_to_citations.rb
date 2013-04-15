class AddAccessedDateToCitations < ActiveRecord::Migration
  def change
    add_column :citations, :accessed_date, :date
  end
end
