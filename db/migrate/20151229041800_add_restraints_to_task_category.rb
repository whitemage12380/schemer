class AddRestraintsToTaskCategory < ActiveRecord::Migration
  def change
    change_column_null :task_categories, :name, false
  end
end
