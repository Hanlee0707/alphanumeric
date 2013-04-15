class AddMoreIndices < ActiveRecord::Migration
  def up
    add_index :articles, :editor_id
  end

  def down
    remove_index :articles, :editor_id
  end
end
