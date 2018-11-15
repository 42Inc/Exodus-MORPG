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
      @page = "User"
      @user = User.find(params[:id])
      @links_navigation_menu = ["Main", "server", "main",
                                "Users", "users", "index"]
      if (@user == nil)
        redirect_to index
      end
    end

    def new
      @page = "New"
      @user = User.new
      @links_navigation_menu = ["Main", "server", "main",
                                "Users", "users", "index"]
    end

    def index
      @page = "Users"
      @links_main_menu = ["Sign in", "sessions", "new",
                          "Sign up", "users", "new",]
      @links_navigation_menu = ["Main", "server", "main"]
    end

    def create #POST
      @page = "Create"
      @user = User.new(params_for_user)
      @links_navigation_menu = ["Main", "server", "main"]
      @user.adm = false
      if @user.save
        log_in @user
        flash[:success] = "Success!"
        redirect_to @user
      else
        render 'new'
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
