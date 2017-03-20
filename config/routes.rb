Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    reviews: 'api/v1/reviews',
    index: '/users'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homepage#index'
  resources :homepage


  resources :games do
    resources :reviews, except: [:index, :show]
  end

  namespace :api do
    namespace :v1 do
      resources :games, only: [:index, :show] do
        resources :reviews
      end
    end
  end

  resources :api, only: [:index]

  devise_for :admins
  resources :admins, only: [:index]
  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user

  resources :users do
    member do
      get 'preview'
    end
  end

  resources :gamerequests

  resources :splash, only: [:index]

  resources :usage, only: [:index]
end
