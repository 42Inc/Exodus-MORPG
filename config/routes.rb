Rails.application.routes.draw do
  root "server#mainpage"
  get '/server' => "server#server"
  get '/server/info' => "server#info"
  get '/server/admconsole' => "server#admconsole"
  get '/game/aboutgame' => "game#aboutgame"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get '/server_controller/server', to: 'server#server'
end
