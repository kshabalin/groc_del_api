Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/v1/auth'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :products, only: %i[index]

      resources :shopping_carts, only: %i[index]

      post "shopping_carts/add", to: "shopping_carts#add"
      post "shopping_carts/remove", to: "shopping_carts#remove"
      delete "shopping_carts/clear", to: "shopping_carts#remove"
    end
  end
end
