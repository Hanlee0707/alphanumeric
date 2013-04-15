class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :article_id
      t.string :image_name
      t.string :type

      t.timestamps
    end
  end
end
