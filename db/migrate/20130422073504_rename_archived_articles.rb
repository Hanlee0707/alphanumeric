class RenameArchivedArticles < ActiveRecord::Migration
  def up
    rename_table :archived_articles, :user_archived_articles
  end

  def down
    rename_table :user_archived_articles, :archived_articles
  end
end
