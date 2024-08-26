Rails.application.routes.draw do
  root to: 'home#index'

  resources :cep_stats, only: [:show]
end
