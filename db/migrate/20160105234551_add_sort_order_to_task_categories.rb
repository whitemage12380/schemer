class AddSortOrderToTaskCategories < ActiveRecord::Migration
  def change
    add_column :task_categories, :sort_order, :integer
  end
end
