require 'rails_helper'

RSpec.describe Admin::UnitsController, type: :controller do
  describe "CREATE"  do
    let(:user) { create(:admin) }
    let(:building) { create(:building) }
    let!(:tenant) { create(:tenant) }
    let!(:owner) { create(:owner) }


    describe "CREATE #create" do
      it "returns http success" do
        sign_in(user)

        post :create, params: {
          unit: {
            number: '101',
            building_id: building.id,
            tenant_id: tenant.id,
            owner_id: owner.id
          }
        }

        expect(response).to have_http_status(302)
        expect(Unit.last.number).to eq(101)
        expect(Unit.last.building_id).to eq(building.id)
        expect(Unit.last.tenant_id).to eq(tenant.id)
        expect(Unit.last.owner_id).to eq(owner.id)
      end

      context "when creating a unit with an existing number" do
        let!(:existing_unit) { create(:unit, number: "101", building: building) }

        it "returns http unprocessable_entity" do
          sign_in(user)

          post :create, params: {
            unit: {
              number: '101',
              building_id: building.id,
              tenant_id: tenant.id,
              owner_id: owner.id
            }
          }

          expect(response).to have_http_status(422)
        end
      end

      context "when creating a unit with owner as a tenant" do
        it "returns http unprocessable_entity" do
          sign_in(user)

          post :create, params: {
            unit: {
              number: '101',
              building_id: building.id,
              tenant_id: owner.id,
              owner_id: owner.id
            }
          }

          expect(response).to have_http_status(422)
        end
      end

      context "when creating a unit with tenant as a owner" do
        it "returns http unprocessable_entity" do
          sign_in(user)

          post :create, params: {
            unit: {
              number: '101',
              building_id: building.id,
              tenant_id: tenant.id,
              owner_id: tenant.id
            }
          }

          expect(response).to have_http_status(422)
        end
      end

      context "when creating a unit without building" do
        it "returns http unprocessable_entity" do
          sign_in(user)

          post :create, params: {
            unit: {
              number: '101',
              building_id: nil,
              tenant_id: tenant.id,
              owner_id: owner.id
            }
          }

          expect(response).to have_http_status(422)
        end
      end
    end
  end
end
