require 'rails_helper'

RSpec.feature "Index Real State", type: :feature do
  let(:user) { create(:admin) }
  let!(:real_states) { create_list(:full_real_state, 24) }

  before do
    login_as(user)
  end

  describe "when visit the index" do
    it do
      visit admin_real_states_path
      fill_in 'real-state-search', with: real_states.last.number
      click_button 'button-real-state-search'

      expect(find("#real-state-number-#{real_states.last.number}")).to have_content(real_states.last.number)

      click_link "show-real-state-#{real_states.last.number}"

      expect(page).to have_content("Finca: #{real_states.last.address}")
    end
  end
end
