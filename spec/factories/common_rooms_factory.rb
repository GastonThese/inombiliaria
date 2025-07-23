FactoryBot.define do
  factory :common_room do
    name { Faker::Name.unique.name }

    factory :full_common_room do
      transient do
        building { nil }
      end

      after(:build) do |common_room, evaluator|
        common_room.building = evaluator.building || create(:building)
      end
    end
  end
end
