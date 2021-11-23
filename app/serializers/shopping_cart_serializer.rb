class ShoppingCartSerializer < Blueprinter::Base
  identifier :id

  field :total_price do |instance|
    instance.total_price
  end

  association :shopping_cart_items, blueprint: ShoppingCartItemSerializer, default: {}
end
