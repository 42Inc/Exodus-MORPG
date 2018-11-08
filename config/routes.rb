Rails.application.routes.draw do
  root "server#main"
  get '/server' => "server#server"
  get '/server/info' => "server#info"
  get '/server/admconsole' => "server#admconsole"
  get '/game' => "game#game"
  get '/game/about' => "game#about"
  resources :users
  get    '/login'   => 'sessions#new'
  post   '/login'   => 'sessions#create'
  delete '/logout'  => 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get '/server_controller/server', to: 'server#server'
end
