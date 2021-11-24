class Api::V1::ProductsController < ApplicationController

  def index
    render_collection_success products
  end

  private

  def products
    Product::Index.perform(filter_params)
  end

  def filter_params
    @filter_params ||= params.permit(:search_value, category_ids: [])
  end
end
