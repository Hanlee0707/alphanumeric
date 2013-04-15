class RenameFyiToDetails < ActiveRecord::Migration
  def up
    rename_column :articles, :fyi, :detail
  end

  def down
    rename_column :article, :detail, :fyi
  end
end
