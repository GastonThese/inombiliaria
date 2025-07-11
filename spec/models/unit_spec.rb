require 'rails_helper'

RSpec.describe Unit, type: :model do
  it { expect(subject).to validate_presence_of(:number) }
  it { is_expected.to belong_to(:owner).optional }
  it { is_expected.to belong_to(:tenant).optional }
  it { is_expected.to belong_to(:building) }

  # Validations investigar uniqueness_of con scope
  it { expect(create(:full_unit)).to validate_uniqueness_of(:number).scoped_to(:building_id) }
end
