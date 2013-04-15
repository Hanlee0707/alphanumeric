Article.transaction do
  (1..100).each do |i|
    Article.create(title: "article #{i}", city: "city #{i}", country: "country #{i}", detail: "prev_content #{i}", current_content: "current_content #{i}", check: false, occurred: "01-01-2007", occurred_time: "2000-01-01 13:00:00")
  end
end
