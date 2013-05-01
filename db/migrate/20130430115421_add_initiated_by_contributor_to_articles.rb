class AddInitiatedByContributorToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :initiated_by_contributor, :boolean
  end
end
