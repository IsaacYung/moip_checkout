Rails.application.routes.draw do
  get 'checkout/customer'
  post 'checkout/customer', to: 'checkout#customer_new', as: :new_checkout_customer

  get 'checkout/payment/:order', to: 'checkout#payment', as: :checkout_payment
  post 'checkout/payment', to: 'checkout#payment_new', as: :create_checkout_payment

  get 'checkout/confirm/:payment_id', to: 'checkout#confirm', as: :checkout_confirm

  post 'checkout/confirm/nofifications', to: 'checkout#update_confirm', as: :update_checkout_confirm

  root to: "catalog#index"

  post '/', to: "catalog#movement"
  resources :products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
