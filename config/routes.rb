Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "pages#index.html.erb"

  resources :pages, only: [:index]

  resources :applications
  resources :trips 
  resources :passengers do 
    resources :trips , only: [:index]
  end
  resources :drivers

end
