require "rails_helper"
RSpec.feature "Create Common Room", type: :feature do
  let(:user) { create(:admin) }
  let(:building) { create(:building) }

  describe "User create common room" do
    before { login_as(user, scope: :user) }

    it 'search by number' do
      visit admin_buildings_path
      fill_in 'building-search', with: building.number
      click_button 'button-building-search'
      name_and_number = find("#building-name-#{building.number}")
      expect(name_and_number).to have_content("#{building.number} - #{building.name}")
      click_link "show-building-#{building.number}"
      click_link "new-common-room-#{building.number}"
      fill_in 'common_room_name', with: 'Sala Común GM'
      click_button 'create-common-room'
      expect(page).to have_content("Se ha creado la sala comunal exitosamente.")
      expect(CommonRoom.last.name).to eq('Sala Común GM')
    end
  end
end
