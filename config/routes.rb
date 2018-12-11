Rails.application.routes.draw do
  #root
  root "server#main"

  #get
  get '/server' => "server#server"
  get '/server/info' => "server#info"
  get '/server/admin' => "server#admin"
  get '/game' => "game#game"
  get '/game/about' => "game#about"
  get '/game/play' => "game#play"
  get '/login'   => 'sessions#new'

  #resources
  resources :users

  #post
  post   '/login'   => 'sessions#create'

  #delete
  delete '/logout'  => 'sessions#destroy'

  #iframe
  get '/server/admin/iframes/:id'   => 'server#admin_iframes'
  get '/game/play/iframes/:id'   => 'game#game_iframes'

  #posts
  post '/server/admin/posts/:id' => 'server#admin_posts'

  #mask other
  get '/server/admin/*permalink' => "server#admin"
  get '/server/*permalink' => "server#main"
  get '/users/*permalink' => "users#play"
  get '/game/*permalink' => "game#game"

  #404
  get '/*permalink' => 'server#notfound'
end
