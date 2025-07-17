require 'rails_helper'

RSpec.describe Admin::RealStatesController, type: :controller do

  before do
    @user = create(:admin)
    sign_in @user
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :showr
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :editr
      expect(response).to have_http_status(:success)
    end
  end
end
