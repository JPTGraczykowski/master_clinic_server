Rails.application.routes.draw do
  devise_for :users, defaults: { format: :json }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :selectors do
    resources :cabinets, only: [:index, :show]
  end

  resources :doctors, only: [:show, :update, :destroy]
end
