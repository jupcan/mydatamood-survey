Rails.application.routes.draw do
  resources :categories
  resources :products do
    put :create, on: :collection
  end
end
