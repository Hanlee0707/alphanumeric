module EditorHelper
  def num_incomplete
    if current_employee.employee_positions.find_by_position("Editor").level >1 then
      Article.where("(status = ? OR status = ? OR status = ?)", "Assigned", "Being Written", "Revoked").size
    else
      Article.where("editor_id = ? and (status = ? OR status = ? OR status = ?)", current_employee.id, "Assigned", "Being Written", "Revoked").size
    end
  end

  def num_review
    if current_employee.employee_positions.find_by_position("Editor").level >1 then
      Article.where("status = ?", "Need Review").size
    else
      Article.where("editor_id = ? and status = ?", current_employee.id, "Need Review").size
    end
  end

  def num_publish
    if current_employee.employee_positions.find_by_position("Editor").level >1 then
      Article.where("status = ?", "Approved").size
    else
      Article.where("editor_id = ? and status = ?", current_employee.id, "Approved").size
    end
  end
end
