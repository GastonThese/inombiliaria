require 'rails_helper'

RSpec.describe Property, type: :model do
  it { expect(subject).to belong_to(:owner).optional }
  it { expect(subject).to belong_to(:tenant).optional }
  it { expect(subject).to belong_to(:building).optional }
  it { expect(create(:full_unit)).to validate_uniqueness_of(:tenant).allow_nil }
  it { expect(create(:full_real_state)).to validate_uniqueness_of(:tenant).allow_nil }
  it { is_expected.to validate_presence_of(:number) }
  it { is_expected.to validate_numericality_of(:number).only_integer }
end
