class CreateAdditionalTexts < ActiveRecord::Migration
  def change
    create_table :additional_texts do |t|
      t.integer :article_id
      t.text :bullet
      t.integer :location

      t.timestamps
    end
  end
end
