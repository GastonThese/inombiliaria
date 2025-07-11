
require 'rails_helper'

RSpec.describe Admin::CreateUnitService, type: :service do
  describe '.call' do
    let(:service) { described_class.new(tenant_id:, building_id:, number:, owner_id:) }
    let!(:buildings) { create(:building) }

    it 'validate building id required' do
      expect { service.call }.to raise_error(ArgumentError, 'Building ID is required')
    end

    it 'validate number required' do
      expect { service.call }.to raise_error(ArgumentError, 'Number is required')
    end

    it 'validate building exist' do
      expect { service.call }.to raise_error(ActiveRecord::RecordNotFound, 'Building not found')
    end

    it 'validate tenant exist' do
      expect { service.call }.to raise_error(ActiveRecord::RecordNotFound, 'Tenant not found')
    end

    it 'validate owner exist' do
      expect { service.call }.to raise_error(ActiveRecord::RecordNotFound, 'Owner not found')
    end

    it 'validate roles: tenant is not owner' do
      expect { service.call }.to raise_error(ArgumentError, 'tenant_id is not a tenant')
    end

    it 'validate roles: owner is not tenant' do
      expect { service.call }.to raise_error(ArgumentError, 'owner_id is not a owner')
    end

    it 'validate number is unique' do
      
    end

    it 'validate unit created' do

    end
  end
end
