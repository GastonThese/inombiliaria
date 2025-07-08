class Building < ApplicationRecord
  validates :name, :address, :number, presence: true
  validates :number, uniqueness: true
end
