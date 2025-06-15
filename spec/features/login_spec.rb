require "rails_helper"
RSpec.feature "Login", type: :feature do
  let(:user) { create(:user) }

  describe "User login" do
    it do
      visit new_user_session_path

      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log in"
      find("#user-menu").click
      user_email = find('#user-email').text
      expect(user_email).to eq(user.email)
    end
  end
end
