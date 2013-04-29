module ArticlesHelper
  include ERB::Util

  def get_contributor(contributor_id)
    contributor= Employee.find(contributor_id)
    "#{contributor.first_name} #{contributor.last_name} (#{contributor.email})"
  end

  def add_definitions(article)
    content = article.current_content
    definitions = article.extra_informations
    definitions.each { |definition|
      explanation = definition[:explanation].sub("\"", "&quot;");
      def_link = link_to(definition[:phrase], "#", data: {content: explanation}, class: 'show_definition_window')
      content = content.gsub(/#{definition[:phrase]}/i, def_link)
    }
    return content
  end

  def calculate_date(article)
    formatted_date = article.occurred.to_s
    final_date_time = formatted_date + " EDT" 
  end

  def parse_date(date)
    date.strftime("%Y-%m-%d %I:%M %p")
  end

  def parse_date_only(date)
    date.strftime("%Y-%m-%d")
  end

  def not_in_published_list(article_id)
    if PublishedItem.find_by_article_id(article_id) then
      return false
    else
      return true
    end
  end

  def link_to_add_tag_button(name, params)
    link_to_function(name, "add_tag(this)", class: params[:class])
  end

  def link_to_remove_fields(name, f, params)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this, \"#{params[:show_gist_link]}\", \"#{params[:show_detail_link]}\")", class:params[:class])
  end

  def link_to_add_fields(name, f, association, params) 
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_"+association.to_s) do |builder|
      if association == :images then
        render association.to_s.singularize + "_fields", :f => builder, :image_type => params[:image_type]
      else
        render( association.to_s.singularize + "_fields", :f => builder)
      end
    end

    fields = fields.gsub("\"", "&quot;");
    
    if params[:hide] ==true then
      link_to name, "#", data: {association: association.to_s, content: fields, target: params[:target], delete: params[:delete]}, class: params[:class] +' add_nested_attributes_button', style:"display:none;", remote: true
    else
     link_to name, "#", data: {association: association.to_s, content: fields, target: params[:target], delete: params[:delete]}, class: params[:class] +' add_nested_attributes_button', remote: true                                                                        
    end
  end 

  def list_of_categories
    categories = []
    categories.append("US")
    categories.append("World")
    categories.append("Politics")
    categories.append("Economy")
    categories.append("Technology")
    categories
  end

end



