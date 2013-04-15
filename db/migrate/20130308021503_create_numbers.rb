class CreateNumbers < ActiveRecord::Migration
  def change
    create_table :numbers do |t|
      t.integer :article_id
      t.string :value
      t.text :explanation

      t.timestamps
    end
  end
end
