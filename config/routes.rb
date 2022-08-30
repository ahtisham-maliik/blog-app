Rails.application.routes.draw do
  get 'groups/index'
  get 'user/index' => "user#show"

  devise_for :users

  root 'groups#index'

  resources :groups
end
