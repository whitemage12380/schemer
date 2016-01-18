json.array!(@tasks) do |task|
  json.extract! task, :id, :user_id, :category_id, :top_category_id, :parent_task_id, :name, :description, :is_complete, :progress_percent, :due_date, :expected_duration_s, :duration_s, :priority, :is_active, :is_common, :sort_order
  json.url task_url(task, format: :json)
end
