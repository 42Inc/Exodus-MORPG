class SessionsController < ApplicationController
  public
    def initialize
      super
      @controller = "Users"
      @page = "Default"
      #link_name, link_controller, link_action
      @links_main_menu = []
      #link_name, link_controller, link_action
      @links_navigation_menu = []
    end

    def new
      @page = "Login"
      @links_navigation_menu = ["Main", "server", "main"]
    end

    def create
      @page = "Login"
      @links_navigation_menu = ["Main", "server", "main"]
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_to user
      else
        flash.now[:danger] = 'Invalid email/password combination'
        render 'new'
      end
    end

    def destroy
      @page = "Destroy"
      @links_navigation_menu = []
      log_out if logged_in?
      redirect_to root_url
    end
end
