class UsersController < ApplicationController
  attr_accessor :adm
  attr_accessor :name, :email
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

    def show
      @page = "Show"
      @user = User.find_by(id: params[:id])
      @links_navigation_menu = ["Main", "server", "main",
                                "Users", "users", "index"]
      if (@user == nil || @user != current_user)
        redirect_to '/users'
      end
    end

    def new
      @page = "New"
      @links_navigation_menu = ["Main", "server", "main",
                                "Users", "users", "index"]
      @user = User.new
    end

    def index
      @page = "Index"
      @links_main_menu = ["Sign in", "sessions", "new",
                          "Sign up", "users", "new",]
      @links_navigation_menu = ["Main", "server", "main"]
    end

    def create #POST
      @page = "New"
      @user = User.new(params_for_user)
      @links_navigation_menu = ["Main", "server", "main"]
      @user.adm = false
      if ServerConfig.first.permit_registration == true
        if @user.save
          log_in @user
          @player = Player.new(id_user: @user.id, name_user: @user.name)
          @player.save
          flash[:success] = "Success!"
          redirect_to @user
        else
          flash[:danger] = "Fail!"
          redirect_to '/users/new'
        end
      else
        flash[:danger] = "Registration is not allowed!"
        redirect_to '/users/new'
      end
    end

    def edit
      @page = "Edit"
    end

    def update #PATCH
      @page = "Update"
    end

    def destroy #DELETE
      @page = "Delete"
    end

  private
    def params_for_user
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
