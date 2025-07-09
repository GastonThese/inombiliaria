class Building < ApplicationRecord
  validates :name, :address, :number, presence: true
  validates :number, uniqueness: true
  has_many :units, dependent: :restrict_with_error
end
