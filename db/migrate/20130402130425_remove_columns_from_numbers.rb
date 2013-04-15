class RemoveColumnsFromNumbers < ActiveRecord::Migration
  def up
    remove_column :numbers, :top_explanation
    remove_column :numbers, :right_explanation
    remove_column :numbers, :left_explanation
    rename_column :numbers, :bottom_explanation, :explanation

  end

  def down
    add_column :numbers, :top_explanation, :text
    add_column :numbers, :right_explanation, :text
    add_column :numbers, :left_explanation, :text
    rename_column :numbers, :explanation, :bottom_explanation
  end
end
