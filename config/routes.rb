Rails.application.routes.draw do
  get 'checkout/customer'
  post 'checkout/customer', to: 'checkout#customer_new'

  get 'checkout/payment'
  post 'checkout/payment', to: 'checkout#payment_new'

  get 'checkout/confirm'

  root to: "catalog#index"

  post '/', to: "catalog#movement"
  resources :products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
