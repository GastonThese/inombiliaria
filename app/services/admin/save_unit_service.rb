class Admin::SaveUnitService
  attr_reader :tenant_id, :owner_id, :building_id, :number
  def initialize(tenant_id:, owner_id:, building_id:, number:)
    @tenant_id = tenant_id
    @owner_id = owner_id
    @building_id = building_id
    @number = number
  end

  def call
    validate_users_and_roles!

    building = Building.find(building_id)

    unit = Unit.new(
      tenant_id:,
      owner_id:,
      building_id:,
      number:
    )

    unit.save
    unit
  rescue ActiveRecord::RecordNotFound => e
    raise e, I18n.t('errors.record_not_found', id: e.id)
  rescue ArgumentError => e
    raise e
  end

  def validate_users_and_roles!
    tenant = User.find(tenant_id) if tenant_id.present?
    owner = User.find(owner_id) if owner_id.present?
    raise ArgumentError, I18n.t('errors.role_not_correct_tenant') unless tenant&.has_role?(:tenant) if tenant.present?
    raise ArgumentError, I18n.t('errors.role_not_correct_owner') unless owner&.has_role?(:owner) if owner.present?
  end
end
