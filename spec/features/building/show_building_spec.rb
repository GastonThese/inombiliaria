require 'rails_helper'
RSpec.feature 'Login', type: :feature do
  let(:user) { create(:admin) }
  let!(:buildings) { create_list(:building, 1) }

  before { login_as(user, scope: :user) }
  describe 'search a building by number and name' do

    it 'show all its data' do
      visit admin_buildings_path

      click_link "show-building-#{buildings.first.number}"

      expect(page).to have_text("Nombre: #{buildings.first.name}")
      expect(page).to have_text("Finca: #{buildings.first.address}")
      expect(page).to have_text("Número: #{buildings.first.number}")
    end

  end

  describe 'Show units from a building' do
    let!(:unit) { create(:unit, building: buildings.first) }

    it 'shows all units from a building' do
      visit admin_buildings_path

      click_link "show-building-#{buildings.first.number}"
      unit_card_number = "#unit-card-number-#{unit.number}"
      expect(find(unit_card_number)).to have_text(unit.number)
    end
  end
end
