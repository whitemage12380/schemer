# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

create_task = (task_name) ->
  task_category_id = $("#task_category_id").val()
  $.ajax
    type: "POST",
    url: "/tasks",
    dataType: "json",
    data: {task: {  
      name:            task_name, 
      category_id:     task_category_id,
      top_category_id: task_category_id
      }},
    success: (data) ->
      add_task_to_list(data)
      return false
    error: (data) ->
      alert ("something didn't work")
      return false

add_task_to_list = (task) ->
  $.ajax
    type: "GET",
    url: "/task_list_item/" + task.id,
    dataType: "json",
    success: (data) ->
      $('.existing_list_item').first().before(data.content)
    error: (data) ->
      alert "it no worky"

$ ->
  new_item_name = $(".new_item_name_overlay")
  # When clicking outside the new task text, hide the overlay
  $("body").mouseup (e) ->
    if not (new_item_name.is(e.target)) and new_item_name.has(e.target).length == 0
      new_item_name.hide()
  # When clicking on the NEW TASK area, show the new item text input overlay
  $(".new_item_label").click ->
    new_item_name.show()
    $("#new_item_name").focus()
  # When pressing Enter inside the new task text input, create the new task in the database
  $("#new_item_name").keyup (e) ->
    if e.keyCode == 13
      create_task($(this).val())
