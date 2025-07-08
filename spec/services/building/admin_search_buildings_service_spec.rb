require 'rails_helper'

RSpec.describe Admin::SearchBuildingsService, type: :service do
  describe '.call' do
    let(:service) { described_class.new(query:, page:) }
    let!(:buildings) { create_list(:building, 50) }

    context 'without query and page' do
      let(:query) { nil }
      let(:page) { nil }

      it 'can search buildings by number' do
        expect(service.call.count).to eq(24)
        expect(service.call).to respond_to(:current_page)
      end
    end

    context 'with query number and page' do
      let(:query) { buildings.first.number }
      let(:page) { 1 }

      it 'can search buildings by number' do
        expect(service.call.first.number).to eq(buildings.first.number)
      end
    end

    context 'with query name and page' do
      let(:query) { 'Building 1' }
      let(:page) { 1 }

      it 'can search buildings by name' do
        buildings.first.update(name: 'Building 1')
        expect(service.call.first.name).to eq(buildings.first.reload.name)
      end
 
    end
  end
end
