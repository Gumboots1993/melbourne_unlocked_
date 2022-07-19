Rails.application.routes.draw do
  devise_for :users
  root to: 'locks#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :locks do
    resources :visits, only: [:create]
  end

  resources :visits, only: [:edit, :update, :show] do
    resources :reviews, only: [:new, :create]
  end

  get 'profile/:username', to: 'pages#profile', as: :profile
  get 'leaderboard', to: 'pages#leaderboard', as: :leaderboard
  get 'locks/new', to: 'locks#new'
end
