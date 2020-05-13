Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "pages#index"

  # this sets up a controller method for pages#index, but we don't need this
  # resources :pages, only: [:index]

  # TODO: clean up routes that are unnecessary
  # resources :applications
  resources :trips, except: [:index]
  resources :passengers do 
    resources :trips, only: [:create]
  end
  resources :drivers 

  patch 'trip/:id/rating', to: 'trips#update_trip_rating', as: 'update_trip_rating'
  patch 'driver/:id/available', to: 'drivers#update_driver_status', as: 'update_driver_status'

end
