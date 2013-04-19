class AddInstructionToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :instruction, :text
  end
end
