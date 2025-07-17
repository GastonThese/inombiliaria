class Unit < Property
  belongs_to :building
  belongs_to :owner, class_name: 'User', optional: true
  belongs_to :tenant, class_name: 'User', optional: true

  validates :number, uniqueness: { scope: :building_id }
  def type
    :unit
  end
end
