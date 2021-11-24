Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/v1/auth'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :products, only: %i[index]

      resource :shopping_cart, only: [:show] do
        post :add
        post :remove
        delete :clear
      end
    end
  end
end
