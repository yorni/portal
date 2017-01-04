Rails.application.routes.draw do
  resources :so_products
  resources :contracts

  devise_for :users

  devise_scope :user do
    authenticated :user do
      root :to => 'orders#index'
    end
    unauthenticated :user do
      root :to => 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  get 'home', to: 'home#index'

  resources :supplier_orders, only: [:index]
  post '/supplier_orders_send', to: 'supplier_orders#create_so'


  resources :order_products do
    patch :send_order, on: :collection # Веб-сервис отправки заявки
  end

  resources :orders do
    patch :get_schedule, on: :collection # Веб-сервис загрузки графика
  end

  resources :receipts, only: [:index, :destroy, :create] do
    #patch :create_receipt, on: :collection # Создание поступления
    get :products, on: :collection
    post :products_update, on: :collection
    patch :send_sa, on: :collection # Веб-сервис отправки поступления
  end

  get '/ajax_get_receipts_for_table', to: 'receipts#ajax_get_receipts_for_table', as: :ajax_get_receipts_for_table
  get '/ajax_get_supplier_orders_for_select', to: 'receipts#ajax_get_supplier_orders_for_select', as: :ajax_get_supplier_orders_for_select
  get '/ajax_get_contracts_for_select', to: 'receipts#ajax_get_contracts_for_select', as: :ajax_get_contracts_for_select


  resources :products
  resources :institutions
  resources :branches
  resources :suppliers
  resources :roles
  resources :users

end
