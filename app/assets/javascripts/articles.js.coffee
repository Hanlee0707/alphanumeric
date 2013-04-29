# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ($) ->
  $(document).on "ready", ->
    $("input[type='submit']").attr('disabled', false)
    $("a").attr('disabled', false)
    existing_issue_tag = $("#article_issue_list").val()
    if existing_issue_tag && ((/^\s*$/.test(existing_issue_tag)) == false)
      $("#issue-search-container").hide()
      hidden_element = $("#article_issue_list")
      $("#issue").text(existing_issue_tag)
      $("#issue-container").show()
    existing_tags = $("#article_tag_list").val()
    tag_list = $("#tag_icons")
    if (existing_tags) && ((/^\s*$/.test(existing_tags)) == false) 
      existing_tags_array = []
      existing_tags_array = existing_tags.toLowerCase().split(",")
      html = []
      i = 0
      while i < existing_tags_array.length
        html.push "<div class='tag_wrap_form'><div class='tag triangle-obtuse'>"
        html.push existing_tags_array[i].trim()
        html.push " "
        html.push "<sup class='remove'>x</sup></div></div>"
        i++
      tag_list.append(html.join('')) 
    $(".datetimepicker2").datetimepicker
      maskInput: false,
      language: 'en',
      pickTime: false
    ht = $(".navbar").height()
    $(".side-contents-bar").css({'top':(ht+'px')})

  $(document).on "change", "#check_all",  (event)->
    if $(this).is(':checked')
      $("input[id*='article_']").prop('checked', true)
      $(".user-action-button").show()
    else
      $("input[id*='article_']").prop('checked', false)	
      $(".user-action-button").hide()

  $(document).on "change", "input[type='checkbox']",  (event)->
    if $(this).is(':checked')
      $(".user-action-button").show()
    else
      if $("input[type='checkbox']:checked").length == 0 or ($("input[type='checkbox']:checked").length == 1 and $("#check_all").is(':checked'))
        $("#check_all").prop('checked', false)
        $(".user-action-button").hide()		

  $(document).on "click", ".set-action",  (event)->
    if $("#user_action").val() == "" 
      event.preventDefault()
      $("#user_action").val($(this).attr("name"))
      $(this).trigger('click')

  $(document).on "click", "a.toggles", (event)->
    event.preventDefault()
    $("a.toggles i").toggleClass "icon-chevron-left icon-chevron-right"
    if $(this).parent().attr("class") == "toggles-container-in" 
      $(this).parent().attr("class", "toggles-container-out")
      $(this).parent().css({'left':($("#sidebar").children().width()+'%')})
    else 
      $(this).parent().attr("class", "toggles-container-in")
      $(this).parent().css({'left':('0px')})
    $("#sidebar").animate
      width: "toggle"
    , 0
    path = window.location.pathname
    if path.indexOf("articles") != -1
      if $("#content").attr("class")=="span12 offset2"
        $("#content").attr("class","span12")
      else 
        $("#content").attr("class","span12 offset2")
    else
      if $("#content").attr("class")=="span10 offset2"
        $("#content").attr("class","span12")
      else 
        $("#content").attr("class","span10 offset2")

  $(document).on "submit", "form", (event)->
    $(this).find("input[type='submit']").val("Working...")
    $("input[type='submit']").attr('disabled', true)
    $("a").attr('disabled', true)


  $(document).on "click", ".hide-form-element", (event)->
    event.preventDefault()
    $(this).parent().parent().siblings('div[id]').toggle()
    $(this).children("b").toggleClass "caret up-caret"

  $(document).on "click", "#revoke_article_button",  (event)->
    event.preventDefault()
    $("#article_status_actions").hide()
    $("#article_revoke_actions").show()

  $(document).on "click", "#cancel_revoke_article_button",  (event)->
    event.preventDefault()
    $("#article_revoke_actions").hide()
    $("#article_status_actions").show()

  $(document).on "click", "#delete_article_button",  (event)->
    event.preventDefault()
    $("#article_actions").hide()
    $("#article_delete_actions").show()

  $(document).on "click", "#cancel_delete_article_button",  (event)->
    event.preventDefault()
    $("#article_delete_actions").hide()
    $("#article_actions").show()
    
  $(document).on "click", "#set_contributor",  (event)->
    event.preventDefault()
    hidden_element = $("#searched_contributor_id")
    if hidden_element.val()==""
      $("#contributor_error").show()	
      $("#contributor_error").fadeOut(2000)
    else 
      $("#contributor_id").val(hidden_element.val())
      $("#contributor_query").hide()
      $("#contributor_container").show()
      $("#contributor_container").html($("#article_contributor_last_name").val())
      $("#remove_contributor_button_container").show()

  $(document).on "click", "#remove_contributor",  (event)->
    event.preventDefault()
    hidden_element = $("#contributor_id")
    hidden_element.val("")
    $("#searched_contributor_id").val("")
    $("#contributor_query").show()
    $("#contributor_container").hide()
    $("#article_contributor_last_name").val("")
    $(this).parent().hide()

  $(document).on "click", "#set_editor",  (event)->
    event.preventDefault()
    hidden_element = $("#searched_editor_id")
    if hidden_element.val()==""
      $("#editor_error").show()	
      $("#editor_error").fadeOut(2000)
    else 
      $("#editor_id").val(hidden_element.val())
      $("#editor_query").hide()
      $("#editor_container").show()
      $("#editor_container").html($("#article_editor_last_name").val())
      $("#remove_editor_button_container").show()

  $(document).on "click", "#remove_editor",  (event)->
    event.preventDefault()
    hidden_element = $("#editor_id")
    hidden_element.val("")
    $("#searched_editor_id").val("")
    $("#editor_query").show()
    $("#editor_container").hide()
    $("#article_editor_last_name").val("")
    $(this).parent().hide()

  $(document).on "click", ".tag_wrap_form",  (event)->
    hidden_element = $("#article_tag_list")
    existing_tags = hidden_element.val().toLowerCase()
    deleted_tag = $(event.tager).children().text().split(" x")[0]
    existing_tags_array = []
    existing_tags_array = existing_tags.split(", ")
    index = existing_tags_array.indexOf(deleted_tag)
    existing_tags_array.splice(index, 1)
    hidden_element.val(existing_tags_array.join(", "))
    $(this).remove()


  $(document).on "click", "#add_issue_tag_button", (event)-> 
    tag_input = $("#throwaway-issue")
    new_tag = tag_input.val().trim().toLowerCase()
    temp_tag_array = new_tag.split(",")
    new_tag = temp_tag_array.join(' ')
    new_tag = new_tag.trim()
    if new_tag !="" 
      $("#issue-search-container").hide()
      hidden_element = $("#article_issue_list")
      hidden_element.val(new_tag)
      $("#issue").text(new_tag)
      $("#issue-container").show()
    else
      $("#throwaway-issue").attr("placeholder", "Invalid tag")

  $(document).on "click", "#remove_issue", (event)-> 
    event.preventDefault()
    $("#issue-search-container").show()
    tag_input = $("#throwaway-issue")
    tag_input.val("")
    hidden_element = $("#article_issue_list")
    hidden_element.val("")
    $("#issue-container").hide()
    
  $(document).on "click", "#throwaway-issue", (event)-> 
    if $(this).attr("placeholder") != "tag (No Comma)" 
      $(this).attr("placeholder", "tag (No Comma)")

  $(document).on "click", "#add_tag_button", (event)-> 
    tag_input = $("#throwaway")
    new_tag = tag_input.val().trim().toLowerCase()
    temp_tag_array = new_tag.split(",")
    new_tag_array = []
    i = 0
    count = 0 
    while i < temp_tag_array.length
      if temp_tag_array[i] != ""  
        new_tag_array.push temp_tag_array[i].trim()
      i++
    new_tag = new_tag_array.join(", ")
    hidden_element = $(this).parent().find("#article_tag_list")
    existing_tags = hidden_element.val().toLowerCase()
    existing_tags_array = []
    existing_tags_array = existing_tags.split(", ")
    i=0
    while i < new_tag_array.length
      single_tag=new_tag_array[i].trim()
      if existing_tags_array.indexOf(single_tag) <= -1 
        if existing_tags==""
          new_tags = single_tag
        else
          new_tags= existing_tags + ", "+ single_tag
        hidden_element.val(new_tags)
        existing_tags = new_tags
        html = []
        html.push "<div class='tag_wrap_form'><div class='tag triangle-obtuse'>"
        html.push single_tag
        html.push " "
        html.push "<sup class='remove'>x</sup></div></div>"
        $("#tag_icons").append(html.join(''))
        tag_input.val("")
      else 
        tag_input.val("")
        tag_input.attr("placeholder", "Some Tags Already Exists")
      i++
      false
        
  $(document).on "click", "#throwaway", (event)-> 
    if $(this).attr("placeholder") != "tags (Separated by commas)" 
      $(this).attr("placeholder", "tags (Separated by commas)")

  $(document).on "click", "#search_button", (event)-> 
    search_key = $("#search_field").val()
    $.get "/search_articles", 
          search: search_key
        , null, "script"

  $(document).on "click", ".show_definition_window", (event)-> 
    event.preventDefault()
    event.stopPropagation()
    target= $(this)
    right = target.offset().left + target.width()
    bottom = target.offset().top + target.height()
    content = target.data("content")
    content_regexp = new RegExp("&quot;", "g")
    content = content.replace(content_regexp, "\"")
    $("#definition_window").html(content)
    $("#definition_window").css({'top': bottom, 'left': right})
    $("#definition_window").show()
    $(document).on "click", ->
      $("#definition_window").hide()
    $(document).on "click", "#definition_window", (event) ->
      event.stopPropagation()
      return false      

  $(document).on "click", ".show_tip", (event)-> 
    event.preventDefault()
    event.stopPropagation()
    target= $(this)
    left = $(this).offset().left - $("#tip_window").width()/2 
    bottom = $(this).offset().top + $(this).height()
    $("#tip_window").css({'top': bottom, 'left': left})
    $("#tip_window").children().text($(this).data("tip"))
    $("#tip_window").show()
    $(document).on "click", ->
      $("#tip_window").hide()
    $(document).on "click", "#tip_window", (event) ->
      event.stopPropagation()
      return false      


  $(document).on "click", ".show_instruction_window", (event)-> 
    event.preventDefault()
    event.stopPropagation()
    target= $(this)
    left = $(this).offset().left 
    bottom = $(this).offset().top + $(this).height()
    $("#instruction_window").css({'top': bottom, 'left': left})
    $("#instruction_window").show()
    $(document).on "click", ->
      $("#instruction_window").hide()
    $(document).on "click", "#instruction_window", (event) ->
      event.stopPropagation()
      return false      


  $(document).on "click", ".show_citations_window", (event)-> 
    event.preventDefault()
    event.stopPropagation()
    target= $(this)
    right = $("#title").offset().left + $("#title").width()/2 - $("#citations_window").width()/2 - 5
    bottom = $("#title").offset().top + $("#title").height()
    $("#citations_window").css({'top': bottom, 'left': right})
    $("#citations_window").show()
    $(document).on "click", ->
      $("#citations_window").hide()
    $(document).on "click", "#citations_window", (event) ->
      event.stopPropagation()
      return false      

    
  $(document).on "click", ".link_summary", (event)-> 
    event.preventDefault()
    highlighted_row = $("tr.highlight td")
    if highlighted_row.is('*') 
      article_id = highlighted_row.children(".article_id").val()
      article_occurred = highlighted_row.children(".article_occurred").val()
      article_title = highlighted_row.children(".article_title").val()
      $(this).parent().siblings().children("input[name*='full_article_id']").val(article_id)
      $(this).parent().siblings().children("input[name*='occurred_date']").val(article_occurred)
      $(this).siblings().show()
      $(this).hide()
      $(this).parent().siblings(".div_title_wrapper").show()
      $(this).parent().siblings(".div_title_wrapper").children(".div_title").html(article_title)
    else 
      $(this).parent().siblings(".div_error").show()
      $(this).parent().siblings(".div_error").fadeOut(1000)

  $(document).on "click", ".unlink_summary", (event)-> 
    event.preventDefault()
    $(this).parent().siblings().children("input[name*='full_article_id']").val("")
    $(this).parent().siblings().children("input[name*='occurred_date']").val("")
    $(this).siblings().show()
    $(this).hide()
    $(this).parent().siblings(".div_title_wrapper").hide()

  $(document).on "click", "#close_card_button", (event)-> 
    event.preventDefault()
    $(this).parent().parent().hide()

  $(document).on "click", ".show_number_explanation_button", (event)-> 
    event.preventDefault()
    $(this).siblings().show()
    $(this).hide()

  $(document).on "click", ".hide_number_explanation_button", (event)-> 
    event.preventDefault()
    $(this).parent().siblings().hide()
    $(this).parent().siblings(".explanation").text("")
    $(this).parent().siblings(".show_number_explanation_button").show()
    $(this).parent().hide()

  $(document).on "click", ".remove_nested_attributes_button", (event)-> 
    event.preventDefault()
    $(this).closest(".fields").find("input[name*='_destroy']").val("1")
    $(".add_gist_image").show()  if $(this).attr("show_gist_link") is "true"
    $(".add_detail_image").show() if $(this).attr("show_detail_link") is "true"
    $(this).closest(".fields").hide()
    if $(this).closest(".fields").parent().attr("id")=="detail_fields"
      $(this).closest(".fields").nextAll(".fields").each ->
        count = parseInt($(this).find("input[id*='location']").val())
        $(this).find("input[id*='location']").val(count-1)
      count = parseInt($("#num_details").val())
      $("#num_details").val(count-1)


  $(document).on "click", ".add_nested_attributes_button", (event)-> 
    event.preventDefault()
    association = $(this).attr("data-association")
    content = $(this).attr("data-content")
    target = $(this).attr("data-target")
    del = $(this).attr("data-delete") 
    new_id = new Date().getTime()
    regexp = new RegExp("new_" + association, "g")
    content_regexp = new RegExp("&quot;", "g")
    content = content.replace(content_regexp, "\"")
    target_id = "#" + target
    html = []
    if association =="numbers"
      html.push "<div class=\"fields row-fluid\" "
    else if association =="extra_informations"
      html.push "<div class=\"fields row-fluid\" "
    else
      html.push "<div class=\"fields row-fluid\" "
    html.push "id="
    html.push new_id
    html.push ">"
    html.push content.replace(regexp, new_id)
    html.push "</div>"
    $(target_id).append html.join('')
    new_id = "#" + new_id
    $(this).hide()  if del=="true"
    if target == "detail_fields" 
      count = parseInt($("#num_details").val())
      $("#num_details").val(count+1)
      $(new_id).find("input[id*='location']").val(count)
    if association == "citations"
      $(".datetimepicker2").datetimepicker
        maskInput: false,
        language: 'en',
        pickTime: false

