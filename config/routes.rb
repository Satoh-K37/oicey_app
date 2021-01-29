Rails.application.routes.draw do
  # get 'users/show'
  root to: 'posts#index'
      
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
    # ,
    # :users => 'users'
  } 

  devise_scope :user do
    get 'sign_in', :to => 'users/sessions#new'
    get 'sign_out', :to => 'users/sessions#destroy'
    get 'profile_edit', :to => 'users/registrations#profile_edit', as: 'profile_edit'
    patch 'profile_update', to: 'users/registrations#profile_update', as: 'profile_update'
  end

  
  
  resources :users do
    get :followings, on: :member
    get :followers, on: :member
    get :matchings, on: :member
  end
  resources :users, only: [:show], as: 'profile'
  resources :relationships, only: [:create, :destroy]
  resources :posts
  
  # get 'home/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
