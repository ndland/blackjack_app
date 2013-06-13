Blackjack::Application.routes.draw do
  resources :lobby, :only => [:index]
  resources :game#, :only => [:show]

  root :to => 'lobby#index'

  match '/game', to: 'game#game'

  namespace :api do
    resources :game do
      resources :bet
      resources :player_cards
    end
    resources :user
  end
end
