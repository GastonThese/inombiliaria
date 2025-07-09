class Unit < ApplicationRecord
  belongs_to :building
  belongs_to :owner, class_name: "User", optional: true
  belongs_to :tenant, class_name: "User", optional: true

  validates :number, presence: true
end
