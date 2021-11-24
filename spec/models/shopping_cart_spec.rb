require 'rails_helper'

RSpec.describe ShoppingCart, type: :model do
  subject(:instance) { build(:shopping_cart) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:shopping_cart_items) }
  it { is_expected.to have_many(:products).through(:shopping_cart_items) }

  it { is_expected.to validate_presence_of(:user) }
end
