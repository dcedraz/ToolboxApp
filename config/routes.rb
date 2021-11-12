Rails.application.routes.draw do
  get 'encoder/index'
  root 'home#index'
  get 'home/about'
  get 'encoder/uploads'
  post 'encoder/uploads'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
