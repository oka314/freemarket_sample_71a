Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'

  end

  root "products#index"
  resources :products do
    resources :comments, only: [:create]
    resources :orders, only: [:new, :create]
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
    member do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
  end
  resources :searches, only: [:index]


  resource :user, only: [:show, :edit, :update] do
    collection do
      get'logout'
      get'bought'
      get'solded'
    end
  end
  resources :cards, only: [:index, :new, :create, :destroy]
  resources :addresses, only: [:edit, :update]

  post   '/like/:product_id' => 'likes#like',   as: 'like'
  delete '/like/:product_id' => 'likes#unlike', as: 'unlike'

  match "*path" => "application#handle_404", via: :all

end
