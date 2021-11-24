FactoryBot.define do
  factory :supplier do
    name { Faker::Name.name }
    category { create(:category) }
  end
end
