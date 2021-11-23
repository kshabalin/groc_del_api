class Product::Index
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def self.perform(params)
    new(params).call
  end

  def call
    scope = initial_scope.eager_load(:category)
    scope = filter_by_search_value(scope) if search_value.present?
    scope = filter_by_category(scope) if category_ids.present?
    scope
  end

  private

  def initial_scope
    Product.all
  end

  def filter_by_search_value(scope)
    scope.search_by_name(search_value)
  end

  def filter_by_category(scope)
    scope.where(category: {id: category_ids})
  end

  def search_value
    @search_value ||= params[:search_value]&.to_s
  end

  def category_ids
    @category_ids ||= params[:category_ids] || []
  end
end
