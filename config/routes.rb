Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  get '/login/guest', to: 'sessions#guest'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  namespace :admin do
    resources :users
  end

  root to: 'monitors#index'
  resources :states

  get '/monitors/:group_id', to: 'monitors#show'
  get '/monitors/:group_id/:member_id', to: 'monitors#show_member'
  #resources :monitors, only: [:index, :show]
  resources :monitors, only: [:index]

  resources :groups

  #get 'gr_members/index'
  get '/gr_members/:group_id', to: 'gr_members#index'
  get '/gr_members/:group_id/edit', to: 'gr_members#edit'
  post '/gr_members/:group_id/edit', to: 'gr_members#update'

  delete '/gr_members/:group_id/:member_id', to: 'gr_members#destroy'

  get 'gr_members/show'
  get '/gr_members/new'
end
