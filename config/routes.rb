Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get :dashboards, to: 'dashboards#profile'
  get :profile, to: 'dashboards#my_profile'

  resources :pokemons do
    resources :bookings, only: %i[new create]
  end

  resources :bookings do
    member do
      patch '/accepted', to: 'bookings#accepted'
      patch '/denied', to: 'bookings#denied'
      patch '/cancelled', to: 'bookings#cancelled'
    end
  end
end
