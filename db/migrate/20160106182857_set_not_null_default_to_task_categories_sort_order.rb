class SetNotNullDefaultToTaskCategoriesSortOrder < ActiveRecord::Migration
  def up
    change_column_null :task_categories, :sort_order, false
    change_column_default :task_categories, :sort_order, 100
  end
  def down
    change_column_null :task_categories, :sort_order, true
    change_column_default :task_categories, :sort_order, nil
  end
end
