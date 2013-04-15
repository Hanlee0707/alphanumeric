class RemoveOccurredTimeFromArticles < ActiveRecord::Migration
  def up
    remove_column :articles, :occurred_time
  end

  def down
    add_column :articles, :occurred_time, :time
  end
end
