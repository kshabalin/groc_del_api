class ShoppingCart::Add
  include ShoppingCart::SharedMethods

  attr_reader :cart
  attr_reader :params

  def initialize(cart, params)
    @cart = cart
    @params = params
  end

  def self.perform(cart, params)
    new(cart, params).call
  end

  def call
    existing_cart_item.present? ? update_cart_item : create_cart_item
  end

  private

  def update_cart_item
    existing_cart_item.amount += 1
    existing_cart_item.save
  end

  def create_cart_item
    ShoppingCartItem.create!(amount: 1, shopping_cart: cart, product: product)
  end
end
