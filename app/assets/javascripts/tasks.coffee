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
      return true
    error: (data) ->
      alert "something didn't work"
      return false

delete_task = (task_id, task_elem) ->
  $.ajax
    type: "DELETE",
    url: "/tasks/#{task_id}",
    dataType: "json",
    success: (data) ->
      task_elem.remove()
      return true
    error: (data) ->
      alert "something didn't work"
      return false

rename_task = (task_id, new_task_name, task_elem) ->
  $.ajax
    type: "PATCH",
    url: "/tasks/#{task_id}",
    dataType: "json",
    data: {task: {  
      name:            new_task_name, 
      }},
    success: (data) ->
      rename_task_in_list(new_task_name, task_elem)
      return true
    error: (data) ->
      alert "something didn't work"
      return false

show_task_detail = (task_id, task_elem) ->
  $.ajax
    type: "GET",
    url: "/task_detail_pane/" + task_id,
    dataType: "json",
    success: (data) ->
      # TODO: Add some visual cue in task list elem
      populate_task_detail_pane(data)
      return true
    error: (data) ->
      alert "it no worky"
      return false

add_task_to_list = (task_id) ->
  $.ajax
    type: "GET",
    url: "/task_list_item/" + task_id,
    dataType: "json",
    success: (data) ->
      $('.new_list_item').first().after(data.content)
      $('.new_item_name_overlay').hide()
      $('#new_item_name').val('')
      return true
    error: (data) ->
      alert "it no worky"
      return false

rename_task_in_list = (new_task_name, task_elem) ->
  task_elem.find(".list_item_name_text").first().text(new_task_name)

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

populate_task_detail_pane = (task_data) ->
  pane = $("#task_detail_sidebar")
  pane.html(task_data.content)

$ ->
  new_item_name = $(".new_item_name_overlay")
  # When clicking outside overlay text, hide the overlay
  $("body").mouseup (e) ->
    # New item overlay
    if not (new_item_name.is(e.target)) and new_item_name.has(e.target).length == 0
      new_item_name.hide()
    # Edit item overlay
    edit_item_names = $(".edit_item_name_overlay")
    if not (edit_item_names.is(e.target)) and edit_item_names.has(e.target).length == 0
      edit_item_names.hide()
  # When clicking on the NEW TASK area, show the new item text input overlay
  $(".new_item_label").click ->
    new_item_name.show()
    $("#new_item_name").focus()
  # When double-clicking an existing task's name, show the edit item text input overlay
  $(".task_list").on dblclick: ->
    overlay = $(this).children(".edit_item_name_overlay")
    input = overlay.children("input").first()
    input.val($(this).text().trim())
    overlay.show()
    input.focus()
  , ".existing_item_name"
  # When pressing Enter inside the new task text input, create the new task in the database
  $("#new_item_name").keyup (e) ->
    if e.keyCode == 13
      create_task($(this).val())
  # When pressing Enter inside the edit task text input, rename the task in the database, or delete the task if no text is there
  $(".task_list").on keyup: (e) ->
    if e.keyCode == 13
      list_item = $(this).closest(".list_item")
      new_name = $(this).val().trim()
      current_name = $(this).closest(".existing_item_name").text().trim()
      switch new_name
        when current_name then $(".edit_item_name_overlay").hide()
        when "" then delete_task(list_item.children(".item_id").val(), list_item)
        else rename_task(list_item.children(".item_id").val(), $(this).val(), list_item)
      $(this).parent(".edit_item_name_overlay").hide()
  , ".edit_item_name"
  # When checking or unchecking the checkbox, persist completion status and change the task list item visuals
  $(".task_complete_checkbox").change ->
    task_id = $(this).val()
    list_item_elem = $(this).parent(".list_item_box")
    mark_task_completion($(this).is(":checked"), task_id, list_item_elem)
  # When hovering over a task list item, show the "+" for add new subtask
  $(".task_list").on mouseenter: ->
    button = $(this).children(".add_sub_item_button").first()
    current_opacity = button.css("opacity")
    button.stop()
    button.animate({opacity: 1}, {duration: (400 - (400 * current_opacity)), queue: false })
  , ".task_list_item"
  $(".task_list").on mouseleave: ->
    button = $(this).children(".add_sub_item_button").first()
    current_opacity = button.css("opacity")
    button.stop()
    button.animate({opacity: 0}, {duration: (400 * current_opacity), queue: false })
  , ".task_list_item"
  # When clicking on the menu button for a list item, reveal verbose task information on the right side-pane
  # TODO: I need to add disambiguating names for all the task interfaces
  $(".task_list").on click: ->
    list_item = $(this).closest(".list_item")
    task_id = list_item.children(".item_id").val()
    show_task_detail(task_id, list_item)
  , ".list_item_menu"
  # When clicking on the "+" new subtask button, create a NEW TASK subtask element if one doesn't already exist
  $(".task_list").on click: ->
    #$(this).parent(".task_list_item")
    alert "create new subtask"
  , ".add_sub_item_button"
  # When clicking on the "-" button that used to be new subtask, remove the NEW TASK subtask element if it exists
    
