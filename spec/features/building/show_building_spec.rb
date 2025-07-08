require 'rails_helper'
RSpec.feature 'Login', type: :feature do
  let(:user) { create(:user) }
  let!(:buildings) { create_list(:building, 1) }

  describe 'search a building by number and name' do
    before { login_as(user, scope: :user) }

    it 'show all its data' do
      visit admin_buildings_path

      click_link "show-building-#{buildings.first.number}"

      expect(page).to have_text("Nombre: #{buildings.first.name}")
      expect(page).to have_text("Finca: #{buildings.first.address}")
      expect(page).to have_text("Número: #{buildings.first.number}")
    end
  end
end
