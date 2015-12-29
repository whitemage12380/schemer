class CreateTaskCategories < ActiveRecord::Migration
  def change
    create_table :task_categories do |t|
      t.integer :user_id
      t.integer :parent_category_id
      t.string :name
      t.string :description
      t.string :color

      t.timestamps null: false
    end
  end
end
