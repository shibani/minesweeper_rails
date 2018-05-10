# frozen_string_literal:true

Rails.application.routes.draw do
  root to: 'site#home'

  get 'site/home'
  post 'site/home', to: 'site#home'

  get '/gameover', to: 'site#gameover'
  post '/gameover', to: 'site#gameover'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
