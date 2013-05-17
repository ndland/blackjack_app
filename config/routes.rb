Blackjack::Application.routes.draw do

  resources :lobby,  :only => [:index] 

  root :to => 'lobby#index'
  
  match '/game', to: 'game#game'

  end