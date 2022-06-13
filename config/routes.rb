Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: :json} do

    # For admim
    get '/users', to: 'users#index'
    get '/user/:user_id', to: 'users#display'
    put '/user/:user_id', to: 'users#update'
    delete '/user/:user_id', to: 'users#destroy'

    # For current user
    get '/user', to: 'users#show'
    post '/users', to: 'users#create'
    put '/change', to: 'users#change'
    delete '/user', to: 'users#exclude'

    post '/login', to: 'authentication#login'

    post '/play', to: 'plays#index'
  end
end
