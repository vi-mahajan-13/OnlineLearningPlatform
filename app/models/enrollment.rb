require 'csv'

class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :course

  def self.to_csv
    attributes = %w{enrollment_id user_email enrolled_at}

    CSV.generate(headers: true) do |csv|
      csv << attributes 

      all.each do |enrollment|
        csv << [
          enrollment.id,
          enrollment.user.email,
          enrollment.created_at,
        ]
      end
    end
  end
end
