Rails.application.routes.draw do
  #root
  root "server#main"

  #get
  get '/server' => "server#server"
  get '/server/info' => "server#info"
  get '/server/admin' => "server#admin"
  get '/game' => "game#game"
  get '/game/about' => "game#about"
  get '/game/gameprocess' => "game#gameprocess"
  get '/login'   => 'sessions#new'

  #resources
  resources :users
  #post

  post   '/login'   => 'sessions#create'

  #delete
  delete '/logout'  => 'sessions#destroy'

  #iframe
  get '/server/admin/:id'   => 'server#admin_iframes'
  #404
  get '/*permalink' => 'server#notfound'
end
