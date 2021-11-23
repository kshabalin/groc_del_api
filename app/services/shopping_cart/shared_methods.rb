module ShoppingCart::SharedMethods
  private

  def product_id
    @product_id ||= params[:product_id]&.to_i
  end

  def existing_cart_item
    @existing_cart_item ||= cart.shopping_cart_items.find_by_product_id(product_id)
  end

  def product
    Product.find(product_id)
  end
end
