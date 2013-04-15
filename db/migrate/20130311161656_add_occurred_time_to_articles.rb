class AddOccurredTimeToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :occurred_time, :time
  end
end
