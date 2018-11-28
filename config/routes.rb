Rails.application.routes.draw do
  root "server#main"
  get '/server' => "server#server"
  get '/server/info' => "server#info"
  get '/server/admin' => "server#admin"
  get '/game' => "game#game"
  get '/game/about' => "game#about"
  get '/game/gameprocess' => "game#gameprocess"
  resources :users
  get    '/login'   => 'sessions#new'
  post   '/login'   => 'sessions#create'
  delete '/logout'  => 'sessions#destroy'
  get '/*permalink' => 'server#notfound'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get '/server_controller/server', to: 'server#server'
end
