class Unit < Property
  after_initialize :set_default_type

  belongs_to :building
  belongs_to :owner, class_name: 'User', optional: true
  belongs_to :tenant, class_name: 'User', optional: true
  default_scope { where(type: 'Unit') }

  validates :number, uniqueness: { scope: :building_id }

  def set_default_type
    self.type ||= 'Unit'
  end
end
