class AddTemporaryTitleToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :temporary_title, :string
  end
end
