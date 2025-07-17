require "cancan/matchers"

describe "User" do
  describe "abilities" do
    subject(:ability) { Ability.new(user) }
    let(:user) { nil }

    context "when is an account manager" do
      let(:user) { create(:admin) }

      it { is_expected.to be_able_to(:delete, Unit.new) }
    end
  end
end
