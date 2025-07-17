require 'rails_helper'
RSpec.feature 'Login', type: :feature do
  let(:user) { create(:admin) }
  let!(:building) { create(:building) }

  describe 'search a building by number and name' do
    before { login_as(user, scope: :user) }

    it 'delete a building' do
      visit admin_buildings_path

      click_button "delete-building-#{ building.number }-modal"

      expect(page).to have_content("¿Confirmas eliminar el edificio #{building.number}?")

      click_button "confirm-delete-#{building.number}"

      expect(Building.all).to be_empty
    end
  end
end
