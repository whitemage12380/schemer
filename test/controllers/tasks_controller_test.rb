require 'test_helper'

class TasksControllerTest < ActionController::TestCase
  setup do
    @task = tasks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tasks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create task" do
    assert_difference('Task.count') do
      post :create, task: { category_id: @task.category_id, description: @task.description, due_date: @task.due_date, duration_s: @task.duration_s, expected_duration_s: @task.expected_duration_s, is_active: @task.is_active, is_common: @task.is_common, is_complete: @task.is_complete, name: @task.name, parent_task_id: @task.parent_task_id, priority: @task.priority, progress_percent: @task.progress_percent, sort_order: @task.sort_order, top_category_id: @task.top_category_id, user_id: @task.user_id }
    end

    assert_redirected_to task_path(assigns(:task))
  end

  test "should show task" do
    get :show, id: @task
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @task
    assert_response :success
  end

  test "should update task" do
    patch :update, id: @task, task: { category_id: @task.category_id, description: @task.description, due_date: @task.due_date, duration_s: @task.duration_s, expected_duration_s: @task.expected_duration_s, is_active: @task.is_active, is_common: @task.is_common, is_complete: @task.is_complete, name: @task.name, parent_task_id: @task.parent_task_id, priority: @task.priority, progress_percent: @task.progress_percent, sort_order: @task.sort_order, top_category_id: @task.top_category_id, user_id: @task.user_id }
    assert_redirected_to task_path(assigns(:task))
  end

  test "should destroy task" do
    assert_difference('Task.count', -1) do
      delete :destroy, id: @task
    end

    assert_redirected_to tasks_path
  end
end
