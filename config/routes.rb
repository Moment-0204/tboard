Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'application#index'
  get 'subpage', to: 'application#sub'
  get 'subpage_2', to:'application#sub1'
  get 'reset', to:'application#reset'

  get 'review/show', to:'reviews#show'
  get 'review/new', to:'reviews#new'
  post 'review/submit', to:'reviews#create'
  get 'review/delete', to:'reviews#delete'
  post 'review/submit_delete', to:'reviews#exc_delete'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/new_user', to:'users#new'
  post '/new_user/submit', to:'users#create'
end