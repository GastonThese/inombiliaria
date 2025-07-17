require 'rails_helper'

RSpec.feature "Create Unit", type: :feature do
  let(:user) { create(:admin) }
  let!(:building) { create(:building) }
  let!(:owner) { create(:owner) }
  let!(:tenant) { create(:tenant) }

  before do
    login_as(user)
  end

  it do
    visit new_admin_unit_path(building_id: building.id)
    fill_in "unit_number", with: "101"
    find("#unit_owner_id option[value='#{owner.id}']").select_option
    find("#unit_tenant_id option[value='#{tenant.id}']").select_option
    click_button "create-unit"
    expect(page).to have_content("La unidad 101 ha sido creada exitosamente")
  end

  describe "when creating a unit with an existing number" do
    let!(:existing_unit) { create(:unit, number: "101", building: building) }
    it do
      visit new_admin_unit_path(building_id: building.id)
      fill_in "unit_number", with: "101"
      find("#unit_owner_id option[value='#{owner.id}']").select_option
      find("#unit_tenant_id option[value='#{tenant.id}']").select_option
      click_button "create-unit"
      expect(page).to have_content("Número de unidad ya ha sido tomado")
    end
  end
end
