class AddOccurredToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :occurred, :date
  end
end
