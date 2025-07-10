FactoryBot.define do
  factory :unit do
    number { Faker::Number.unique.number(digits: 3) }

    factory :full_unit do
      transient do
        owner { nil }
        tenant { nil }
        building { nil }
      end

      after(:build) do |unit, evaluator|
        unit.owner = evaluator.owner || create(:owner)
        unit.tenant = evaluator.tenant || create(:tenant)
        unit.building = evaluator.building || create(:building)
      end
    end
  end
end
