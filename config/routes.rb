Rails.application.routes.draw do
  resources :users, only: [:create]
  resources :categories, only: [:index, :show, :create]
  resources :interests, only: [:create]

  resources :products, only: [:index, :show] do
    put :create, on: :collection
  end
end