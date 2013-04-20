# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ($) ->
  $(document).on "ready", ->
    btnHeight = parseInt($("#password").outerHeight()) + parseInt($("#email").parent().height())
    $("#login_button").css({'height':(btnHeight+'px')})

