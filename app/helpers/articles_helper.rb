module ArticlesHelper
  include ERB::Util
  require 'htmlentities'

  def get_contributor(contributor_id)
    contributor= Employee.find(contributor_id)
    "#{contributor.first_name} #{contributor.last_name} (#{contributor.email})"
  end

  def add_definitions(article)
    coder = HTMLEntities.new
    content = article.current_content
    if !content.nil? then
      definitions = article.extra_informations
      puts content
      index = 0
      content = "<span>" + content + "</span>"
      original_content = content
      definitions.each { |definition|
        explanation = definition[:explanation]
        escaped_phrase = coder.encode(definition[:phrase])
        if definition[:phrase] != escaped_phrase then
          escaped_phrase_decimal = coder.encode(definition[:phrase], :decimal)
          escaped_phrase_basic = coder.encode(definition[:phrase], :basic)
          escaped_phrase_named = coder.encode(definition[:phrase], :named)
          escaped_phrase_hex = coder.encode(definition[:phrase], :hexadecimal)
        end
        def_link = link_to(definition[:phrase], "#", data: {content: explanation}, class: 'show_definition_window', style: "color:rgb(112, 17, 18);font-weight:bold;" )
        content = content.sub(/#{escaped_phrase}(?=[^>]*(<))/i, def_link)
        if definition[:phrase] != escaped_phrase and original_content == content then
          content = content.sub(/#{escaped_phrase_decimal}(?=[^>]*(<))/i, def_link)
          if content == original_content then
            content = content.sub(/#{escaped_phrase_basic}(?=[^>]*(<))/i, def_link)
          end
          if content == original_content then
            content = content.sub(/#{escaped_phrase_named}(?=[^>]*(<))/i, def_link)
          end
          if content == original_content then
            content = content.sub(/#{escaped_phrase_hex}(?=[^>]*(<))/i, def_link)
          end
        end  

                         }
 
      return content
    end
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
        render "articles/fields/"+ association.to_s.singularize + "_fields", :f => builder, :image_type => params[:image_type]
      else
        render( "articles/fields/"+association.to_s.singularize + "_fields", :f => builder)
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



