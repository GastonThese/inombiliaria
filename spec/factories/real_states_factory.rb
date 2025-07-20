FactoryBot.define do
  factory :real_state do
    number { Faker::Number.unique.number(digits: 3) }
    
    factory :full_real_state do
      transient do
        owner { nil }
        tenant { nil }
        address { nil }
      end

      after(:build) do |unit, evaluator|
        unit.owner = evaluator.owner || create(:owner)
        unit.tenant = evaluator.tenant || create(:tenant)
        unit.address = evaluator.address || Faker::Address.full_address
      end
    end
  end
end
