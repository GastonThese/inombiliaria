require 'rails_helper'
RSpec.feature 'Login', type: :feature do
  let(:user) { create(:user) }
  let!(:buildings) { create(:building) }

  describe 'search a building by number and name' do
    before { login_as(user, scope: :user) }

    it 'show all its data' do
      visit admin_buildings_path

      click_link "show-building-#{buildings.number}"

      

    end
  end
end
