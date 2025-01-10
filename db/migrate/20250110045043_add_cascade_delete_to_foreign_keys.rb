class AddCascadeDeleteToForeignKeys < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :completed_lessons, :users
    remove_foreign_key :courses, :users
    remove_foreign_key :enrollments, :users

    add_foreign_key :completed_lessons, :users, on_delete: :cascade
    add_foreign_key :courses, :users, on_delete: :cascade
    add_foreign_key :enrollments, :users, on_delete: :cascade
  end
end
