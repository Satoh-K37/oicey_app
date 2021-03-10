Rails.application.routes.draw do
  get 'messages/create'
  get 'messages/destroy'
  get 'rooms/index'
  get 'rooms/create'
  get 'rooms/show'
  # get 'users/show'
  root to: 'posts#index'
      
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
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
    get :show, as: 'profile', on: :member
  end
  resources :rooms, only: [:index, :create, :show]
  resources :messages, only: [:create, :edit, :update, :destroy]

  resources :relationships, only: [:create, :destroy]
  resources :notifications, only: :index
  
  resources :posts do
    # postのidを取ってくるためにネストしている
    resource :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    # resource :images, only: [:new, :create, :destroy]
  end

  
  # get 'home/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
