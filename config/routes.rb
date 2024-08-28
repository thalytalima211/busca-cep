Rails.application.routes.draw do
  root to: 'home#index'

  resources :cep_stats, only: [:show] do
    get 'most_searched', on: :collection
  end
end
