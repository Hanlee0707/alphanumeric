class FixColumnName < ActiveRecord::Migration
  def up
    rename_column :articles, :previous_content, :fyi
  end

  def down
  end
end
