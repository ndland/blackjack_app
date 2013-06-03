Blackjack::Application.routes.draw do
  resources :lobby, :only => [:index]
  resources :game#, :only => [:show]

  root :to => 'lobby#index'

  match '/game', to: 'game#game'

  # resources :user

  namespace :api do
    resources :user
    resources :bet
  end
end
