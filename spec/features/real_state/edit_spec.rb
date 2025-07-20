require 'rails_helper'

RSpec.feature "Edit Real State", type: :feature do
  let(:user) { create(:admin) }
  let!(:real_state) { create(:full_real_state) }
  let!(:owner) { create(:owner) }
  let!(:tenant) { create(:tenant) }

  before do
    login_as(user)
  end

  describe "when visit the edit" do
    it do
      visit edit_admin_real_state_path(real_state)
      fill_in 'real_state_address', with: 'Some new address'
      fill_in 'real_state_number', with: '123'
      find("#real_state_owner_id option[value='#{owner.id}']").select_option
      find("#real_state_tenant_id option[value='#{tenant.id}']").select_option
      click_button 'save-real-state'
      expect(real_state.reload.address).to have_content("Some new address")
      expect(real_state.reload.number).to have_content("123")
      expect(page).to have_content("Propietario: #{owner.email}")
      expect(page).to have_content("Inquilino: #{tenant.email}")
    end
  end
end
