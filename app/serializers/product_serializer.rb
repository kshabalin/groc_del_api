class ProductSerializer < Blueprinter::Base
  identifier :id

  field :name
  association :category, blueprint: CategorySerializer, default: {}
  association :supplier, blueprint: SupplierSerializer, default: {}
end
