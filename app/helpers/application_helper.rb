module ApplicationHelper

  def sortable(column, title = nil )
    title ||= column.titleize
    if sort_direction == "asc" then
      direction = "desc"
    else
      direction = "asc"
    end
    link_to title, params.merge(:sort => column, :direction => direction, :page=>nil)
  end

  def store_back
    session[:return_to] = request.referer
  end

end
