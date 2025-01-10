class CreateCompletedLessons < ActiveRecord::Migration[7.1]
  def change
    create_table :completed_lessons do |t|
      t.references :user, null: false, foreign_key: true
      t.references :lesson, null: false, foreign_key: true
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
