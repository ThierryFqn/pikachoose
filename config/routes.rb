Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users
  resources :pokemons, only: %i[index new create] # do
  # resources :bookings, only: %i[new create]
  # end
end
