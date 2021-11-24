require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do
  let!(:category1) { create(:category) }
  let!(:supplier1) { create(:supplier, category: category1) }
  let!(:product1) { create(:product, category: category1, supplier: supplier1) }

  let!(:category2) { create(:category) }
  let!(:supplier2) { create(:supplier, category: category2) }
  let!(:product2) { create(:product, category: category2, supplier: supplier2) }

  let(:filter_params) {}

  shared_examples "product list" do |count:|
    it "returns OK" do
      expect(response.status).to eq(200)
    end

    it "returns correct items count" do
      expect(response_json["data"].count).to eq(count)
    end

    it "returns correct data structure" do
      expect(response_json[:data]).to all include(
        id: (kind_of Integer),
        name: (kind_of String),
        category: {
          id: (kind_of Integer),
          name: (kind_of String),
        },
        supplier: {
          id: (kind_of Integer),
          name: (kind_of String),
        }
      )
    end
  end

  describe "#index" do
    let(:make_request) { get :index, params: filter_params }

    context "when has empty filters" do
      before { make_request }

      it_behaves_like "product list", count: 2
    end

    context "when has search value" do
      let(:filter_params) { {search_value: product1.name} }

      before { make_request }

      it_behaves_like "product list", count: 1

      it "returns the correct product" do
        expect(response_json[:data][0][:name]).to eq(product1.name)
      end
    end

    context "when has category ids" do
      let(:filter_params) { { category_ids: [category2.id] } }

      before { make_request }

      it_behaves_like "product list", count: 1

      it "returns the correct product" do
        expect(response_json[:data][0][:name]).to eq(product2.name)
      end
    end
  end
end
