class Admin::CreateUnitService
  def initialize(tenant_id:, owner_id:, building_id:, number:)
    @tenant_id = tenant_id
    @owner_id = owner_id
    @building_id = building_id
    @number = number
  end

  def call
    validate!
  end


  def validate!
    validate_building_exists!
    validate_tenant_exists!
    validate_owner_exists!
    validate_roles!
  end

  private

  def validate_building_exists!
    Building.find(@building_id)
  end

  def validate_tenant_exists!
    User.find(@tenant_id)
  end

  def validate_owner_exists!
    User.find(@owner_id)
  end

  def validate_roles!
    raise ArgumentError, 'tenant_id is not a tenant' unless User.find(@tenant_id).has_role?(:tenant)
    raise ArgumentError, 'owner_id is not a owner' unless User.find(@owner_id).has_role?(:owner)
  end
end
