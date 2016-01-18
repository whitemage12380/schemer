class TaskCategory < ActiveRecord::Base
  # Associations
  has_many :task_categories, class_name: "TaskCategory", foreign_key: "parent_category_id", dependent: :destroy
  has_many :tasks, foreign_key: "category_id", dependent: :destroy
  has_many :tasks, foreign_key: "top_category_id", dependent: :destroy
end
