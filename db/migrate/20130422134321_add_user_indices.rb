class AddUserIndices < ActiveRecord::Migration
  def up
    add_index :user_archived_articles, :user_id
    add_index :user_archived_articles, :article_id
    add_index :user_followed_articles, :user_id
    add_index :user_followed_articles, :article_id
    add_index :user_read_articles, :user_id
    add_index :user_read_articles, :article_id
    add_index :users, :email
  end

  def down
    remove_index :user_archived_articles, :user_id
    remove_index :user_archived_articles, :article_id
    remove_index :user_followed_articles, :user_id
    remove_index :user_followed_articles, :article_id
    remove_index :user_read_articles, :user_id
    remove_index :user_read_articles, :article_id
    remove_index :users, :email
  end
end
