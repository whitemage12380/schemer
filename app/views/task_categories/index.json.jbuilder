json.array!(@task_categories) do |task_category|
  json.extract! task_category, :id, :user_id, :parent_category_id, :name, :description, :color
  json.url task_category_url(task_category, format: :json)
end
