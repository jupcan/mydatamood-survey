Rails.application.routes.draw do
  resources :users, only: [:create]
  resources :categories, only: [:index, :create]
  resources :interests, only: [:create]

  resources :products, only: [:index] do
    put :create, on: :collection
  end
end