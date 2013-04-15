class RenameDetailsToPreviousSummary < ActiveRecord::Migration
  def up
    rename_column :articles, :detail, :previous_summary
  end

  def down
    rename_column :articles, :previous_summary, :detail
  end
end
