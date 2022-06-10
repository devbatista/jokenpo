Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: :json} do
    resources :users, param: :_username

    post '/login', to: 'authentication#login'

    post '/jogar', to: 'plays#index'
  end
end
