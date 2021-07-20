Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#home'
  get 'about', to: 'welcome#about'
  get 'signup', to: 'users#new'
  # post 'users', to: 'users#create'
  resources :users, except: [:new]
  resources :articles
end
