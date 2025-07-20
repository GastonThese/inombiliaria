class CommonRoom < ApplicationRecord
  belongs_to :building
  validates :name, presence: true
end
