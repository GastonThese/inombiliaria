require 'rails_helper'

RSpec.describe Property, type: :model do
  it { expect(subject).to belong_to(:owner).optional }
  it { expect(subject).to belong_to(:tenant).optional }
  it { expect(subject).to belong_to(:building).optional }
  it { is_expected.to validate_presence_of(:number) }
end
