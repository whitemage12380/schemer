class Task < ActiveRecord::Base
  # Associations
  has_many :tasks, class_name: "Task", foreign_key: "parent_task_id", dependent: :destroy
end
