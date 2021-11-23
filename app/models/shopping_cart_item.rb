class ShoppingCartItem < ApplicationRecord
  belongs_to :shopping_cart
  belongs_to :product

  validates :amount, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 1, only_integer: true }
  validates :shopping_cart, uniqueness: { scope: [:product] }
end
