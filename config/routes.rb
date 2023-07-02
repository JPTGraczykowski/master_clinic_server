Rails.application.routes.draw do
  devise_for :users, defaults: { format: :json }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :selectors do
    resources :cabinets, only: [:index]
    resources :specialties, only: [:index]
    resources :datetime_slots, only: [:index]
    resources :doctors, only: [:index]
  end

  resources :doctors, except: [:edit] do
    patch :archive, on: :member
  end
  resources :patients, except: [:edit] do
    patch :archive, on: :member
  end
  resources :appointments, except: [:edit]
  resources :datetime_slots, except: [:edit]
end
