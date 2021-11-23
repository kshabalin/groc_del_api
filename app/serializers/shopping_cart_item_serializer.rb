class ShoppingCartItemSerializer < Blueprinter::Base
  identifier :id

  field :amount
  association :product, blueprint: ProductSerializer, default: {}
end
