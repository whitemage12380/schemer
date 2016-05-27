class AddTimestampsToAllTimezones < ActiveRecord::Migration
  def up
    change_column :tasks, :due_date, "timestamp with time zone"
    change_column :tasks, :created_at, "timestamp with time zone"
    change_column :tasks, :updated_at, "timestamp with time zone"
    change_column :task_categories, :created_at, "timestamp with time zone"
    change_column :task_categories, :updated_at, "timestamp with time zone"
  end
  def down
    change_column :tasks, :due_date, :timestamp
    change_column :tasks, :created_at, :timestamp
    change_column :tasks, :updated_at, :timestamp
    change_column :task_categories, :created_at, :timestamp
    change_column :task_categories, :updated_at, :timestamp
  end
end
