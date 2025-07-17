require 'rails_helper'

RSpec.describe RealState, type: :model do
  it { expect(subject).to validate_presence_of(:number) }
  it { is_expected.to belong_to(:owner).optional }
  it { is_expected.to belong_to(:tenant).optional }


  context 'when building id is null' do
    it 'not allow duplicates numbers' do
      create(:full_real_state, number: 'A1')

      duplicated = build(:full_real_state, number: 'A1')
      expect(duplicated).to be_invalid
      expect(duplicated.errors[:number]).to include(I18n.t('activerecord.errors.models.real_state.attribute.number.taken'))
    end
  end
end
