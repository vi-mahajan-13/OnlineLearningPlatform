class Profile < ApplicationRecord
  belongs_to :user
  has_one :picture, as: :imageable, dependent: :destroy


  validates :name, presence: true
  validates :age, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  validates :date_of_birth, presence: true, allow_nil: false
  validates :city, presence: true
  validates :pincode, presence: true
  validates :phone_number, presence: true, length: { is: 10 } 
end
