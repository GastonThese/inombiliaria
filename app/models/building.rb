class Building < ApplicationRecord
  validates :name, :address, :number, presence: true
end
