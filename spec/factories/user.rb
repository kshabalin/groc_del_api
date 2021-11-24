FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Alphanumeric.unique.alphanumeric(number: 10) }
    uid { Faker::Alphanumeric.unique.alphanumeric(number: 10) }
    provider { :email }
    password { Faker::Internet.password }
  end
end
