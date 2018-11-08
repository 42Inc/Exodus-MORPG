class UsersController < ApplicationController
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
    end

    def new
      @page = "New"
      @user = User.new
      @links_navigation_menu = ["Main", "server", "main",
                                "Users", "users", "index"]
    end

    def index
      @page = "Users"
      @links_main_menu = ["Sign up", "users", "new"]
      @links_navigation_menu = ["Main", "server", "main"]
    end

    def create #POST
      @page = "Create"
      @user = User.new(params_for_user)
      @links_navigation_menu = []
      if @user.save
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

    def destroy #DELEYE
      @page = "Delete"
    end

  private
    def params_for_user
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
