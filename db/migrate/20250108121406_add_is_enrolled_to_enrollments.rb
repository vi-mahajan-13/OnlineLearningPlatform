class AddIsEnrolledToEnrollments < ActiveRecord::Migration[7.1]
  def change
    add_column :enrollments, :is_enrolled, :boolean, default: false
  end
end
