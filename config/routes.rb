Rails.application.routes.draw do
  # get 'toppages/index'
  root to: 'toppages#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root to: 'tasks#index'
  resources :tasks
end
