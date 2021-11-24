FactoryBot.define do
  factory :product do
    supplier { create(:supplier) }
    category { supplier.category }

    name { Faker::Name.name }
    price { Faker::Number.between(from: 1, to: 10) }
  end
end
