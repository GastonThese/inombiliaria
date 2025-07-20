require 'rails_helper'

RSpec.describe Admin::CommonRoomsController, type: :controller do
  let(:admin) { create(:admin) }

  before do
    sign_in admin
  end

  # describe "GET #show" do
  #   it "returns http success" do
  #     get :show
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  describe "GET #new" do
    let(:building) { create(:building) }

    it "returns http success" do
      get :new, params: { building_id: building.id }
      expect(response).to render_template(:new)
    end
  end

  # describe "GET #create" do
  #   it "returns http success" do
  #     post :create
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET #edit" do
  #   it "returns http success" do
  #     get :edit
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET #update" do
  #   it "returns http success" do
  #     put :update
  #     expect(response).to have_http_status(:success)
  #   end
  # end
end
