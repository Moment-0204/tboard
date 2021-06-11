Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'application#index'
  get 'subpage', to: 'application#sub'
  get 'subpage_2', to:'application#sub1'
  get 'reset', to:'application#reset'

  get 'review/show', to:'reviews#show'
  get 'review/new', to:'reviews#new'
  post 'review/submit', to:'reviews#create'

end