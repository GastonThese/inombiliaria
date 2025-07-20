require 'rails_helper'

RSpec.feature "Show Real State", type: :feature do
  let(:user) { create(:admin) }
  let!(:real_state) { create(:full_real_state) }

  before do
    login_as(user)
  end

  describe "when visit the show" do
    it do
      visit admin_real_state_path(real_state)
      expect(page).to have_content("Número: #{real_state.number}")
      expect(page).to have_content("Inquilino: #{real_state.tenant.email}")
      expect(page).to have_content("Propietario: #{real_state.owner.email}")
      expect(page).to have_content('Editar')
    end
  end
end
