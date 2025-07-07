FactoryBot.define do
  factory :building do
    number { Faker::Number.unique.number(digits: 3) }
    name { Faker::Name.unique.name }
    address { Faker::Address.street_address }
  end
end
