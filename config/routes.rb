Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'application#index'
  get 'subpage', to: 'application#sub'
  get 'subpage_2', to:'application#sub1'

end