Rails.application.routes.draw do
  resources :users
  resources :categories
  resources :interests

  resources :products do
    put :create, on: :collection
  end
end
