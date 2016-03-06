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
      add_task_to_list(data.id)
      return false
    error: (data) ->
      alert ("something didn't work")
      return false

add_task_to_list = (task_id) ->
  $.ajax
    type: "GET",
    url: "/task_list_item/" + task_id,
    dataType: "json",
    success: (data) ->
      $('.existing_list_item').first().before(data.content)
    error: (data) ->
      alert "it no worky"

mark_task_completion = (completion_state, task_id, list_item_elem = null) ->
  $.ajax
    type: "PATCH",
    url: "/tasks/" + task_id,
    dataType: "json",
    data: {
      task: { is_complete: completion_state }
    },
    success: (data) ->
      if list_item_elem != null
        if completion_state
          list_item_elem.addClass("completed_task")
        else
          list_item_elem.removeClass("completed_task")
      return false
    error: (data) ->
      alert data
      return false

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
  $(".task_complete_checkbox").change ->
    task_id = $(this).val()
    #task_id = $(this).siblings(".task_id").first().val()
    list_item_elem = $(this).parent(".list_item")
    mark_task_completion($(this).is(":checked"), task_id, list_item_elem)
