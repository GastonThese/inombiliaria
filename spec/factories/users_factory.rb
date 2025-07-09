FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { 'password123' }

    factory :admin do
      after(:create) { |user| user.add_role(:admin) }
    end

    factory :tenant do
        after(:create) { |user| user.add_role(:tenant) }
    end

    factory :owner do
        after(:create) { |user| user.add_role(:owner) }
    end

    factory :user_owner_with_units do
        after(:build) { |user| user.add_role(:owner) }

        after(:create) do |user|
          building = create(:building)
          create_list(:unit, 10, owner: user, tenant: create(:tenant), building:)
        end
    end
  end
end
