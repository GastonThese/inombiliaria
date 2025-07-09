FactoryBot.define do
  factory :unit do
    number { 1 }
    owner factory: :user
    tenant factory: :user
  end
end
