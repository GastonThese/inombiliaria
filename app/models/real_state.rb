class RealState < Property
  after_initialize :set_default_type

  belongs_to :owner, class_name: 'User', optional: true
  belongs_to :tenant, class_name: 'User', optional: true
  default_scope { where(type: 'RealState') }

  validates :address, presence: true
  validate :unique_number_when_building_id_nil

  def unique_number_when_building_id_nil
    return if building_id.present?
  
    if self.class.where(number: number, building_id: nil).where.not(id: id).exists?
      errors.add(:number, I18n.t('activerecord.errors.models.real_state.attribute.number.taken'))
    end
  end
  
  def set_default_type
    self.type ||= 'RealState'
  end
end
