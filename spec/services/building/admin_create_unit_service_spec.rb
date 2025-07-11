
require 'rails_helper'

RSpec.describe Admin::CreateUnitService, type: :service do
  describe '.call' do
    let(:service) { described_class.new(tenant_id:, building_id:, number:, owner_id:) }

    context 'validations' do
      describe do
        let!(:building) { create(:building) }
        let(:tenant_id) { create(:tenant).id }
        let(:building_id) { building.id }
        let(:number) { '101' }
        let(:owner_id) { create(:owner).id }

        it 'validate building exist' do
          building.destroy
          expect { service.call }.to raise_error(ActiveRecord::RecordNotFound, 'Building not found')
        end
      end

      describe do
        let!(:building) { create(:building) }
        let(:tenant) { create(:tenant) }
        let(:tenant_id) { tenant.id }
        let(:building_id) { building.id }
        let(:number) { '101' }
        let(:owner_id) { create(:owner).id }

        it 'validate tenant exist' do
          expect { service.call }.to raise_error(ActiveRecord::RecordNotFound, 'Tenant not found')
        end
      end


      describe do
        let!(:building) { create(:building) }
        let(:tenant) { create(:tenant) }
        let(:tenant_id) { tenant.id }
        let(:building_id) { building.id }
        let(:number) { '101' }
        let(:owner) { create(:owner) }
        let(:owner_id) { owner.id }

        it 'validate owner exist' do
          owner.destroy
          expect { service.call }.to raise_error(ActiveRecord::RecordNotFound, 'Owner not found')
        end
      end

      describe do
        let!(:building) { create(:building) }
        let(:tenant) { create(:owner) }
        let(:tenant_id) { tenant.id }
        let(:building_id) { building.id }
        let(:number) { '101' }
        let(:owner) { create(:owner) }
        let(:owner_id) { owner.id }

        it 'validate roles: tenant is not owner' do
          expect { service.call }.to raise_error(ArgumentError, 'tenant_id is not a tenant')
        end
      end

      describe do
        let!(:building) { create(:building) }
        let(:tenant) { create(:tenant) }
        let(:tenant_id) { tenant.id }
        let(:building_id) { building.id }
        let(:number) { '101' }
        let(:owner) { create(:owner) }
        let(:owner_id) { owner.id }

        it 'validate roles: owner is not tenant' do
          expect { service.call }.to raise_error(ArgumentError, 'owner_id is not a owner')
        end
      end


      it 'validate unit created' do
      end
    end
  end
end
