class Api::V1::ShoppingCartsController < ApplicationController
  before_action :authenticate_user!

  def index
    render_shopping_cart
  end

  def add
    ShoppingCart::Add.perform(shopping_cart, add_to_cart_params)
  end

  def remove
    ShoppingCart::Remove.perform(shopping_cart, add_to_cart_params)
  end

  def clear
    shopping_cart.shopping_cart_items.destroy_all
  end

  private

  def render_shopping_cart
    render_success shopping_cart
  end

  def shopping_cart
    @shopping_cart ||= current_user.shopping_cart
  end

  def add_to_cart_params
    params.permit(:product_id)
  end
end
