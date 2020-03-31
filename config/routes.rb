Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  # root 'products#index'
  root "orders#new"
  
  resources :products, only: [:index, :show, :new, :create] do
    resources :orders, only: [:new, :create]
  end

  resource :user, only: [:show, :edit, :update] do
    collection do
      get'logout'
    end
  end
  resources :cards, only: [:index, :new, :create, :destroy]
end
