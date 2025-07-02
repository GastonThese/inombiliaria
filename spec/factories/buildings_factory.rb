FactoryBot.define do
  factory :building do
    number { Faker::Number.number(digits: 3) }
    name { Faker::Name.name }
    address { Faker::Address.full_address }
  end
end
