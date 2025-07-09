require 'rails_helper'

RSpec.describe Building, type: :model do
  it { expect(subject).to validate_presence_of(:name) }
  it { expect(subject).to validate_presence_of(:address) }
  it { expect(subject).to validate_presence_of(:number) }
  it { expect(build(:building)).to validate_uniqueness_of(:number) }
  it { is_expected.to have_many(:units) }
end
