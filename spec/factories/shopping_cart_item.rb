FactoryBot.define do
  factory :shopping_cart_item do
    shopping_cart
    amount { Faker::Number.between(from: 1, to: 10) }
  end
end
