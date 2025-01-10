class AddCascadeDeleteToEnrollmentsAndLessons < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :enrollments, :courses
    remove_foreign_key :enrollments, :users
    remove_foreign_key :lessons, :courses

    add_foreign_key :enrollments, :courses, on_delete: :cascade
    add_foreign_key :enrollments, :users, on_delete: :cascade
    add_foreign_key :lessons, :courses, on_delete: :cascade
  end
end
