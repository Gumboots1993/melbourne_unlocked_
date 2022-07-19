Rails.application.routes.draw do
  devise_for :users
  root to: 'locks#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'locks/new-lock-request', to: 'locks#new_lock'

  resources :locks do
    resources :visits, only: [:create]
    resources :reviews, only: [:new, :create]
  end

  resources :visits, only: [:edit, :update, :show]

  get 'profile/:username', to: 'pages#profile', as: :profile
  get 'leaderboard', to: 'pages#leaderboard', as: :leaderboard
  get 'locks/new', to: 'locks#new'
end
