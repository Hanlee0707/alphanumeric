class AddContributorIdToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :contributor_id, :integer
  end
end
