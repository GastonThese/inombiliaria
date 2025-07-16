require 'rails_helper'

RSpec.feature "Show Unit", type: :feature do
  let(:user) { create(:admin) }
  let!(:unit) { create(:full_unit, number: "101") }

  before do
    login_as(user)
  end

  describe "when updating a unit" do
    let!(:new_owner) { create(:owner) }

    it do
      visit admin_unit_path(unit)
      expect(page).to have_content("Edificio: #{unit.building.number}-#{unit.building.name}")
      expect(page).to have_content("Finca: #{unit.building.address}")
      expect(page).to have_content("Número: #{unit.number}")
      expect(page).to have_content("Inquilino: #{unit.tenant.email}")
      expect(page).to have_content("Propietario: #{unit.owner.email}")
      expect(page).to have_content('Editar')
    end
  end
end
