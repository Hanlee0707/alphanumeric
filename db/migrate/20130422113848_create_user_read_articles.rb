class CreateUserReadArticles < ActiveRecord::Migration
  def change
    create_table :user_read_articles do |t|
      t.integer :article_id
      t.integer :user_id

      t.timestamps
    end
  end
end
