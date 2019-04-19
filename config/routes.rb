Rails.application.routes.draw do
  # resources :readings
  # resources :thermostats
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'readings#index'
  resources :readings
  resources :thermostats
end
