class Task < ActiveRecord::Base
  # Associations
  belongs_to :user
  belongs_to :task_category, foreign_key: "category_id"
  belongs_to :task_category, foreign_key: "top_category_id"
  has_many :tasks, class_name: "Task", foreign_key: "parent_task_id", dependent: :destroy

  # Validations
  validates_each :category_id, :top_category_id do |record, attr, value|
    record.errors.add(attr, 'must have the same user as this task') if TaskCategory.find(value).user_id == @user_id
    #record.errors.add(attr, 'must have the same user as this task') 
  end
end
