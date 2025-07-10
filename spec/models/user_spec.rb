require 'rails_helper'

RSpec.describe User, type: :model do
  it { expect(subject).to validate_presence_of(:email) }
  it { expect(subject).to validate_presence_of(:password) }
  it { expect(subject).to have_many(:properties) }
  it { expect(subject).to have_one(:rented_unit) }

  context "user utilities" do
    let!(:owner) { create(:user_owner_with_units) }

    it 'how to get all tenants' do
      expect(User.joins(:rented_unit).uniq.count).to eq(10)
    end

    it 'how to get all properties form owner' do
      expect(owner.properties.count).to eq(10)
    end

    it 'how to get tenant rented unit / real state' do
      unitId = User.with_role(:tenant).first.rented_unit.id
      expect(unitId).to eq(Property.find(unitId).id)
    end
  end
end
