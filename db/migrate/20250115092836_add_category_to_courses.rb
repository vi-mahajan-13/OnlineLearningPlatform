class AddCategoryToCourses < ActiveRecord::Migration[7.1]
  def change
    add_reference :courses, :category, null: true, foreign_key: true
  end
end
