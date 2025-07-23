require "rails_helper"
RSpec.feature "Edit Common Room", type: :feature do
  let(:user) { create(:admin) }
  let(:building) { create(:building) }
  let!(:common_room) { create(:common_room, building: building) }

  describe "User create common room" do
    before { login_as(user, scope: :user) }

    it 'search by number' do
      visit admin_buildings_path
      fill_in 'building-search', with: building.number
      click_button 'button-building-search'
      name_and_number = find("#building-name-#{building.number}")
      click_link "show-building-#{building.number}"
      click_link "show-common-room-#{common_room.id.gsub!('-', '')}"
      click_link "edit-common-room-#{common_room.name}"
      fill_in 'common_room_name', with: 'Sala Común GM Editada'
      click_button 'update-common-room'
      expect(page).to have_content("Se ha actualizado la sala comunal exitosamente.")
      expect(CommonRoom.last.name).to eq('Sala Común GM Editada')
    end
  end
end
