require 'rails_helper'

RSpec.describe User, type: :model do
  it { expect(subject).to validate_presence_of(:email) }
  it { expect(subject).to validate_presence_of(:password) }
  it { expect(subject).to have_many(:properties) }
  it { expect(subject).to have_one(:rented_unit) }
end
