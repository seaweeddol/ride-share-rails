Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "pages#index"

  # this sets up a controller method for pages#index, but we don't need this
  # resources :pages, only: [:index]

  # TODO: clean up routes that are unnecessary
  # resources :applications
  resources :trips # maybe not necessary
  resources :passengers do 
    resources :trips
  end
  resources :drivers do 
    resources :trips , only: [:index]
  end

end
