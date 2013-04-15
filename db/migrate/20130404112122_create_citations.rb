class CreateCitations < ActiveRecord::Migration
  def change
    create_table :citations do |t|
      t.integer :article_id
      t.string :author
      t.string :title
      t.date :published_date
      t.string :publisher
      t.string :link

      t.timestamps
    end
  end
end
