class User < ApplicationRecord
  has_many :courses

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: %i[student instructor admin]
  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role = :student
  end
end
