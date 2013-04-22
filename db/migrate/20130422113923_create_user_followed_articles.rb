class CreateUserFollowedArticles < ActiveRecord::Migration
  def change
    create_table :user_followed_articles do |t|
      t.integer :article_id
      t.integer :user_id

      t.timestamps
    end
  end
end
