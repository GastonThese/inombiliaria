class Admin::CreateUnitService
  def initialize(tenant_id:, owner_id:, building:, number:)
    @tenant_id = tenant_id
    @owner_id = owner_id
    @building = building
    @number = number
  end
end
