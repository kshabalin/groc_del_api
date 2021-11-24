require 'rails_helper'

RSpec.describe ShoppingCartItem, type: :model do
  subject(:instance) { build(:shopping_cart_item) }

  it { is_expected.to belong_to(:shopping_cart) }
  it { is_expected.to belong_to(:product) }

  it { is_expected.to validate_presence_of :amount }
  it { is_expected.to validate_numericality_of(:amount).is_greater_than_or_equal_to(1).only_integer }
end
