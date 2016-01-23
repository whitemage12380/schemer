class Task < ActiveRecord::Base
  # Associations
  belongs_to :user
  belongs_to :task_category, foreign_key: "category_id"
  has_many :tasks, class_name: "Task", foreign_key: "parent_task_id", dependent: :destroy
end
