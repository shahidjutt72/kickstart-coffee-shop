Rails.application.routes.draw do
  root to: 'dashboard#index' # Default page is the dashboard

  # Devise routes for user authentication
  devise_for :users

  resources :dashboard, only: [:index]
  resources :carts, only: [:show]
  resources :products do
    member do
      post :add_to_cart
    end
  end
  devise_scope :user do
  	get 'users/sign_out', :to => "devise/sessions#destroy"
  end

  namespace :admin do
  	root to: 'tax_rates#index'
    resources :tax_rates
  	resources :discounts, only: [:index, :new, :create, :edit, :update]
  end
end
