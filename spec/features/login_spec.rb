require "rails_helper"
RSpec.feature "Login", type: :feature, js: true do

  describe "User login" do
    it do
      visit new_user_session_path

      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      puts page.html
      click_button "Log in"
      click_button "#user-menu"
      user_email = find('#user-email').text
      expect(user_email).to eq(user.email)
    end
  end
end
