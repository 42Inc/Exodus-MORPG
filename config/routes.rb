Rails.application.routes.draw do
  #root
  root "server#main"

  #get
  get '/server' => "server#server"
  get '/server/info' => "server#info"
  get '/server/admin' => "server#admin"
  get '/server/notfound' => 'server#notfound'
  get '/game' => "game#game"
  get '/game/about' => "game#about"
  get '/game/play' => "game#play"
  get '/game/dead' => "game#dead"
  get '/login'   => 'sessions#new'

  #resources
  resources :users

  #post
  post   '/login'   => 'sessions#create'

  #delete
  delete '/logout'  => 'sessions#destroy'

  #posts
  post '/server/admin/posts/:id' => 'server#admin_posts'
  post '/game/posts/:id' => 'game#game_posts'

  #iframe
  get '/server/admin/iframes_1/:id'   => 'server#admin_iframes_1'
  get '/server/admin/iframes_2/:id'   => 'server#admin_iframes_2'
  get '/server/admin/iframes_3/:id'   => 'server#admin_iframes_3'
  get '/game/play/iframes_1/:id'   => 'game#game_iframes_1'
  get '/game/play/iframes_3/:id'   => 'game#game_iframes_3'

  #mask other
  get '/server/admin/*permalink' => "server#admin"
  get '/server/*permalink' => "server#main"
  get '/users/*permalink' => "users#play"
  get '/game/*permalink' => "game#game"

  #404
  get '/*permalink' => 'server#notfound'
end
