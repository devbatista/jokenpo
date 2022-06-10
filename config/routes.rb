Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: :json} do
    get '/users', to: 'users#index'
    get '/user/:user_id', to: 'users#show'
    post '/users', to: 'users#create'
    put '/user/:user_id', to: 'users#update'
    delete '/user/:user_id', to: 'users#destroy'

    post '/login', to: 'authentication#login'

    post '/play', to: 'plays#index'
  end
end
