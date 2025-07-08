require "rails_helper"
RSpec.feature "Login", type: :feature do
  let(:user) { create(:user) }

  describe "User creatw build" do
    before { login_as(user, scope: :user) }
    it do
      visit new_admin_building_path
      fill_in "building_name", with: "Building 1"
      fill_in "building_address", with: "Calle 1"
      fill_in "building_number", with: "1"
      click_button "create-building"
      expect(page).to have_content("Edificio Building 1 creado correctamente.")
    end
  end
end
