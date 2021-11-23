class ShoppingCart::Remove
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
    update_cart_item if existing_cart_item.present?
  end

  private

  def update_cart_item
    existing_cart_item.amount -= 1
    existing_cart_item.valid? ?  existing_cart_item.save :  existing_cart_item.destroy!
  end
end
