class RemoveOccurredFromArticles < ActiveRecord::Migration
  def up
    remove_column :articles, :occurred
      end

  def down
    add_column :articles, :occurred, :datetime
  end
end
