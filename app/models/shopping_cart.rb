class ShoppingCart < ApplicationRecord
  belongs_to :user
  has_many :shopping_cart_items
  has_many :products, through: :shopping_cart_items

  validates :user, presence: true

  def total_price
    shopping_cart_items.inject(0) { |sum, i| sum + i.amount * i.product.price }
  end
end
