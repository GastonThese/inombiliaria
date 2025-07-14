
require 'rails_helper'

RSpec.describe Admin::SaveUnitService, type: :service do
  describe '.call' do
    let(:service) { described_class.new(tenant_id:, building_id:, number:, owner_id:) }
    let!(:building) { create(:building) }
    let(:tenant) { create(:tenant) }
    let(:tenant_id) { tenant.id }
    let(:building_id) { building.id }
    let(:number) { 101 }
    let(:owner) { create(:owner) }
    let(:owner_id) { owner.id }

    context 'validations' do
      describe do
        it 'validate building exist' do
          building.destroy
          expect { service.call }.to raise_error(ActiveRecord::RecordNotFound, I18n.t('errors.record_not_found', id: building.id))
        end
      end

      describe do
        it 'validate tenant exist' do
          tenant.destroy
          expect { service.call }.to raise_error(ActiveRecord::RecordNotFound, I18n.t('errors.record_not_found', id: tenant.id))
        end
      end


      describe do
        it 'validate owner exist' do
          owner.destroy
          expect { service.call }.to raise_error(ActiveRecord::RecordNotFound, I18n.t('errors.record_not_found', id: owner.id))
        end
      end

      describe do
        let(:tenant) { create(:owner) }

        it 'validate roles: tenant is not owner' do
          expect { service.call }.to raise_error(ArgumentError, I18n.t('errors.role_not_correct_tenant'))
        end
      end

      describe do
        let(:owner) { create(:tenant) }

        it 'validate roles: owner is not tenant' do
          expect { service.call }.to raise_error(ArgumentError, I18n.t('errors.role_not_correct_owner'))
        end
      end


      describe 'validate unit created' do
        it { expect(service.call).to be_a(Unit) }
        it { expect(service.call.number).to eq(number.to_i) }
      end

      it 'no can create unit with same number in the same building, but is validated for model' do
        service.call
        expect(service.call.valid?).to be(false)
      end
    end
  end
end
