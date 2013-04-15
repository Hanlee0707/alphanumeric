class CreateExtraInformations < ActiveRecord::Migration
  def change
    create_table :extra_informations do |t|
      t.integer :article_id
      t.string :phrase
      t.text :explanation

      t.timestamps
    end
  end
end
