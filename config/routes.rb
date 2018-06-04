# frozen_string_literal:true

Rails.application.routes.draw do
  root to: 'site#home'

  get '/home', to: 'site#home'
  post 'home', to: 'site#game_config'

  get '/new', to: 'site#new'
  post '/new', to: 'site#update'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
