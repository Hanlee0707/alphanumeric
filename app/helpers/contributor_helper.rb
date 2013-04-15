module ContributorHelper
  def num_contributor_incomplete
    Article.where("contributor_id =? AND (status = ? OR status = ? OR status =?)", current_employee.id, "Assigned", "Being Written", "Revoked").size
  end

  def num_contributor_review
    Article.where("contributor_id=? and status = ?", current_employee.id, "Need Review").size
  end

  def num_contributor_revoked
    Article.where("contributor_id=? and status = ?", current_employee.id, "Revoked").size
  end
end
