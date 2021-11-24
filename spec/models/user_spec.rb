require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:instance) { build(:user) }

  it { is_expected.to have_one(:shopping_cart) }
  it { is_expected.to have_many(:products).through(:shopping_cart) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_least(1) }
  it { is_expected.to validate_presence_of(:uid) }
  it { is_expected.to validate_length_of(:uid).is_at_least(1) }

  it { is_expected.to allow_value(Faker::Internet.email).for(:email) }
  it { is_expected.not_to allow_value(Faker::Lorem.word).for(:email) }
end
