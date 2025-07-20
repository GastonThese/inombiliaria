require 'rails_helper'

RSpec.describe Admin::SearchRealStatesService, type: :service do
  describe '.call' do
    let(:service) { described_class.new(query:, page:) }
    let!(:real_states) { create_list(:full_real_state, 50) }

    

    context 'without query and page' do
      let(:query) { nil }
      let(:page) { nil }

      it 'can search real_states by number' do
        expect(service.call.count).to eq(24)
        expect(service.call).to respond_to(:current_page)
      end
    end

    context 'with query number and page' do
      let(:query) { real_states.first.number }
      let(:page) { 1 }

      it 'can search real_states by number' do
        expect(service.call.first.number).to eq(real_states.first.number)
      end
    end
  end
end
