class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.integer :category_id
      t.integer :top_category_id
      t.integer :parent_task_id
      t.string :name, null: false
      t.string :description
      t.boolean :is_complete, default: false
      t.integer :progress_percent, default: 0
      t.timestamp :due_date
      t.integer :expected_duration_s
      t.integer :duration_s
      t.integer :priority
      t.boolean :is_active, null: false, default: true
      t.boolean :is_common, null: false, default: false
      t.integer :sort_order, default: 100

      t.timestamps null: false
    end
    add_foreign_key :tasks, :users
    add_foreign_key :tasks, :task_categories, column: :category_id
    add_foreign_key :tasks, :task_categories, column: :top_category_id
    add_foreign_key :tasks, :tasks, column: :parent_task_id
    add_foreign_key :task_categories, :users
    add_foreign_key :task_categories, :task_categories, column: :parent_category_id
  end
end
