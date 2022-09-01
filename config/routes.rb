Rails.application.routes.draw do
  get 'groups/index'
  get 'user/index' => "user#show"

  devise_for :users

  root 'groups#index'

  resources :groups do
    resources :posts
    get '/:id/join_group', to: 'groups#join_group', as: :join, on: :collection
    get '/:id/leave_group/:user_id', to: 'groups#leave_group', as: :leave, on: :collection
  end
end
