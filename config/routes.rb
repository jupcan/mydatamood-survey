Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/'
  mount Rswag::Api::Engine => '/api-docs'

  resources :users, only: [:create]
  resources :categories, only: [:index]
  resources :interests, only: [:create]

  resources :products, only: [:index] do
    put :create, on: :collection
  end
end
