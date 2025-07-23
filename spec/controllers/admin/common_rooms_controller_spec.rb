require 'rails_helper'

RSpec.describe Admin::CommonRoomsController, type: :controller do
  let(:admin) { create(:admin) }

  before do
    sign_in admin
  end

  describe "GET #show" do
    let(:building) { create(:building) }
    let(:common_room) { create(:common_room, building: building) }
    let(:common_room_params) do
      {
        building_id: building.id,
        id: common_room.id
      }
    end

    it "returns http success" do
      get :show, params: common_room_params
      expect(response).to have_http_status(:success)
    end

    describe "GET #edit" do
      it "returns http success" do
        get :edit, params: common_room_params
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "GET #new" do
    let(:building) { create(:building) }

    it "returns http success" do
      get :new, params: { building_id: building.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    let(:building) { create(:building) }
    let(:common_room_params) do
      {
        building_id: building.id,
        common_room: {
          name: "Sala Común ARA"
        }
      }
    end

    it "returns http success" do
      post :create, params: common_room_params
      expect(response).to have_http_status(302)
      expect(flash[:notice]).to eq("Se ha creado la sala comunal exitosamente.")
      expect(CommonRoom.last.name).to eq("Sala Común ARA")
    end

    it "return unprocessable entity when invalid" do
      post :create, params: common_room_params.merge(common_room: { name: nil })
      expect(response).to have_http_status(422)
    end
  end

  describe "GET #update" do
    it "returns http success" do
      put :update, params: {
        id: create(:full_common_room).id,
        building_id: create(:building).id,
        common_room: {
          name: "Sala Común Actualizada"
        }
      }
      expect(response).to have_http_status(302)
      expect(flash[:notice]).to eq("Se ha actualizado la sala comunal exitosamente.")
      expect(CommonRoom.last.name).to eq("Sala Común Actualizada")
    end

    it "returns unprocessable entity when invalid" do
      put :update, params: {
        id: create(:full_common_room).id,
        building_id: create(:building).id,
        common_room: {
          name: nil
        }
      }
      expect(response).to have_http_status(422)
    end
  end
end
