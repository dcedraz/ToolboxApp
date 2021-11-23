Rails.application.routes.draw do
  get 'encoder/index'
  root 'home#index'
  get 'home/about'
  post 'encoder/upload'
  post 'encoder/verify'
  get 'encoder/upload'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
