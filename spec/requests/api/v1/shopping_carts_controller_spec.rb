require 'rails_helper'

RSpec.describe Api::V1::ShoppingCartsController, type: :controller do
  let!(:category1) { create(:category) }
  let!(:supplier1) { create(:supplier, category: category1) }
  let!(:product1) { create(:product, category: category1, supplier: supplier1, price: 10.0) }

  let!(:category2) { create(:category) }
  let!(:supplier2) { create(:supplier, category: category2) }
  let!(:product2) { create(:product, category: category2, supplier: supplier2, price: 20.0) }

  let(:user) { create(:user) }
  let!(:shopping_cart) { create(:shopping_cart, user: user) }

  let(:cart_params) {}

  shared_examples "unauthenticated" do
    before { make_request }

    it "returns 401" do
      expect(response.status).to eq(401)
    end
  end

  shared_examples "OK" do
    it "returns OK" do
      expect(response.status).to eq(200)
    end
  end

  shared_examples "shopping cart data" do |count:, total_price:|
    it "returns correct shopping cart items count" do
      expect(response_json["data"]["shopping_cart_items"].count).to eq(count)
    end

    it "returns correct total price" do
      expect(response_json["data"]["total_price"]).to eq(total_price)
    end
  end

  describe "#show" do
    let(:make_request) { get :show }

    context "when user is unauthenticated" do
      it_behaves_like "unauthenticated"
    end

    context "when user is authenticated" do
      before { authenticate(user) }

      context "when shopping cart is empty" do
        before { make_request }

        it_behaves_like "OK"
      end

      context "when shopping cart contains 1 item of a product" do
        let!(:shopping_cart_item) do
          create(:shopping_cart_item, product: product1, amount: 1, shopping_cart: shopping_cart)
        end

        before { make_request }

        it_behaves_like "OK"

        it_behaves_like "shopping cart data", count: 1, total_price: 10.0
      end

      context "when shopping cart contains 2 items of the same product" do
        let!(:shopping_cart_item) do
          create(:shopping_cart_item, product: product1, amount: 2, shopping_cart: shopping_cart)
        end

        before { make_request }

        it_behaves_like "OK"

        it_behaves_like "shopping cart data", count: 1, total_price: 20.0
      end

      context "when shopping cart contains 2 items of different products" do
        let!(:shopping_cart_item1) do
          create(:shopping_cart_item, product: product1, amount: 1, shopping_cart: shopping_cart)
        end
        let!(:shopping_cart_item2) do
          create(:shopping_cart_item, product: product2, amount: 1, shopping_cart: shopping_cart)
        end

        before { make_request }

        it_behaves_like "OK"

        it_behaves_like "shopping cart data", count: 2, total_price: 30.0
      end
    end
  end

  describe "#add" do
    let(:make_request) { get :add, params: cart_params }

    context "when user is unauthenticated" do
      it_behaves_like "unauthenticated"
    end

    context "when user is authenticated" do
      before { authenticate(user) }

      context "when shopping cart product count is increased by 1" do
        let(:cart_params) { {product_id: product1.id} }

        it "creates shopping cart item" do
          expect { make_request }.to change(ShoppingCartItem, :count).by(1)
        end
      end
    end
  end

  describe "#remove" do
    let(:make_request) { get :remove, params: cart_params }

    context "when user is unauthenticated" do
      it_behaves_like "unauthenticated"
    end

    context "when user is authenticated" do
      before { authenticate(user) }

      context "when shopping cart product count is decreased by 1" do
        let(:cart_params) { {product_id: product1.id} }
        let!(:shopping_cart_item) do
          create(:shopping_cart_item, product: product1, amount: 1, shopping_cart: shopping_cart)
        end

        it "removes shopping cart item" do
          expect { make_request }.to change(ShoppingCartItem, :count).by(-1)
        end
      end
    end
  end

  describe "#clear" do
    let(:make_request) { get :clear }

    context "when user is unauthenticated" do
      it_behaves_like "unauthenticated"
    end

    context "when user is authenticated" do
      before { authenticate(user) }

      context "when all shopping cart items removed" do
        let!(:shopping_cart_item1) do
          create(:shopping_cart_item, product: product1, amount: 1, shopping_cart: shopping_cart)
        end
        let!(:shopping_cart_item2) do
          create(:shopping_cart_item, product: product2, amount: 1, shopping_cart: shopping_cart)
        end

        it "removes shopping cart items" do
          expect { make_request }.to change(ShoppingCartItem, :count).by(-2)
        end
      end
    end
  end
end
