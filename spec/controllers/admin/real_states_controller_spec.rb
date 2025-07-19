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

  context 'real state' do
    let!(:real_state) { create(:full_real_state) }
    describe "GET #show" do
      it "returns http success" do
        get :show, params: { id: real_state.id }
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #edit" do
      it "returns http success" do
        get :edit, params: { id: real_state.id }
        expect(response).to have_http_status(:success)
      end
    end

    describe "UPDATE #update" do
      it 'Update the real state' do
        put :update, params: { id: real_state.id, real_state: { number: '2' } }
        expect(response).to have_http_status(302)
        expect(real_state.reload.number).to eq(2)
      end
      it 'number nil on UPDATE' do
        put :update, params: { id: real_state.id, real_state: {  number: nil, address: 'address' } }
        expect(response).to have_http_status(422)
      end

      it 'string on number UPDATE' do
        put :update, params: { id: real_state.id, real_state: {  number: 'string', address: 'address' } }
        expect(response).to have_http_status(422)
      end

      it 'Address nil' do
        put :update, params: { id: real_state.id, real_state: { number: 90, address: nil } }
        expect(response).to have_http_status(422)
      end

    end

    describe "CREATE #create" do
      it 'Create new real state' do
        post :create, params: { real_state: {  number: '5', address: 'mi casa' } }
        expect(response).to have_http_status(302)
        expect(RealState.find_by(address: 'mi casa').number).to eq(5)
      end

      it 'number nil on CREATE' do
        post :create, params: { real_state: {  number: nil, address: 'address' } }
        expect(response).to have_http_status(422)
      end

      it 'string on number CREATE' do
        post :create, params: { real_state: {  number: 'a', address: 'address' } }
        expect(response).to have_http_status(422)
      end

      it 'address nil on CREATE' do
        post :create, params: { real_state: {  number: 'a', address: nil } }
        expect(response).to have_http_status(422)
      end
    end
  end
end
