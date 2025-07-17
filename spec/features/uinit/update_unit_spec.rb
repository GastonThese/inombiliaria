require 'rails_helper'

RSpec.feature "Update Unit", type: :feature do
  let(:user) { create(:admin) }
  let!(:building) { create(:building) }
  let!(:owner) { create(:owner) }
  let!(:tenant) { create(:tenant) }
  let!(:unit) { create(:unit, number: "101", building: building, owner: owner, tenant: tenant) }

  before do
    login_as(user)
  end

  describe "when updating a unit" do
    let!(:new_owner) { create(:owner) }

    it do
      visit edit_admin_unit_path(unit, params: { building_id: building.id })
      find("#unit_owner_id option[value='#{new_owner.id}']").select_option
      find("#unit_tenant_id option[value='#{tenant.id}']").select_option
      click_button "create-unit"
      expect(page).to have_content("La unidad 101 ha sido actualizada exitosamente")
    end
  end
end
