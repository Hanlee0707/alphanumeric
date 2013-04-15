class RenameExplanationToTopExplanation < ActiveRecord::Migration
  def up
    rename_column :numbers, :explanation, :top_explanation
    add_column :numbers, :bottom_explanation, :text
    add_column :numbers, :left_explanation, :text
    add_column :numbers, :right_explanation, :text
  end

  def down
    rename_column :numbers, :top_explanation, :explanation
    remove_column :numbers, :bottom_explanation
    remove_column :numbers, :left_explanation
    remove_column :numbers, :right_explanation
  end
end
