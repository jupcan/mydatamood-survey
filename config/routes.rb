Rails.application.routes.draw do
  resources :products do
    put :create, on: :collection
  end
end
