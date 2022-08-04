Rails.application.routes.draw do
  root 'home#index'
  get 'home/index'
  get 'users/:id/password', to: 'users#password', as: 'password'
  post 'users/:id/updatePassword', to: 'users#update_password', as: 'update_password'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  resources :subordinates
  resources :statistics
  resources :masters
  resources :users
  resources :organizations
  
  # get 'organizations/index'
  # get 'organizations/edit'
  # get 'organizations/update'
  # get 'sessions/new'
  # resources :employs
  # get 'users/:id/edit', to: 'users#edit', as: 'edit_user'
  # put 'users/:id', to: 'users#update', as: 'user'
  # get 'users/index'
  # get 'users/edit'
  # get 'users/show'
  # get 'employs/index'
  # get 'employs/show'
  # get 'employs/edit'
  # get 'employs/:id/editSkill', to: 'employs#editSkill', as: 'editSkill_employ'
  # get 'statistics/index'
  # get 'masters/index'
  # get 'masters/edit'
  # get 'masters/show'
  # get 'subordinates/index'
  # get 'subordinates/edit'
  # get 'subordinates/show'
  # get 'emploies/index'
  # get 'emploies/show'
  # get 'emploies/edit'
end
