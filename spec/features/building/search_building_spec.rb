require 'rails_helper'
RSpec.feature 'Search building', type: :feature do
  let(:user) { create(:admin) }
  let!(:buildings) { create_list(:building, 50) }
  let(:building) { buildings.first }
  let(:other_building) { buildings.last }

  describe 'search a building by number and name' do
    before { login_as(user, scope: :user) }

    it 'search by number' do
      visit admin_buildings_path
      fill_in 'building-search', with: building.number
      click_button 'button-building-search'
      name_and_number = find("#building-name-#{building.number}")
      expect(name_and_number).to have_content("#{building.number} - #{building.name}")
    end

    it 'search by name' do
      visit admin_buildings_path
      fill_in 'building-search', with: other_building.name
      click_button 'button-building-search'
      name_and_number = find("#building-name-#{other_building.number}")
      expect(name_and_number).to have_content("#{other_building.number} - #{other_building.name}")
    end
  end
end
