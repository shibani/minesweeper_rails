Rails.application.routes.draw do
  get 'site/home'
  root to: 'site#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
