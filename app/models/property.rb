class Property < ApplicationRecord
  belongs_to :owner, class_name: 'User', optional: true
  belongs_to :tenant,  class_name: 'User', optional: true
  belongs_to :building, optional: true

  validates :number, presence: true
  validates :number, numericality: { only_integer: true }
  validates :tenant, uniqueness: { allow_nil: true }
end
