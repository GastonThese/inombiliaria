FactoryBot.define do
  factory :building do
    number { Faker::Number.unique.number(digits: 3) }
    name { Faker::Name.unique.name }
    address { Faker::Address.street_address }

    factory :building_with_units do
      transient do
        units_count { 5 }
      end

      after(:create) do |building, evaluator|
        create_list(:unit, evaluator.units_count, building: building)
      end
    end
  end
end
