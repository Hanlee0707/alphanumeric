class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :city
      t.string :country
      t.text :previous_content
      t.text :current_content

      t.timestamps
    end
  end
end
