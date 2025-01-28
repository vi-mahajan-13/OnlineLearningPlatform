require 'csv'

class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :course

  def self.to_csv
    attributes = %w{id user_name course_title created_at updated_at}

    CSV.generate(headers: true) do |csv|
      csv << attributes 

      all.each do |enrollment|
        csv << [
          enrollment.id,
          enrollment.user.email,
          enrollment.created_at,
          enrollment.updated_at 
        ]
      end
    end
  end
end
