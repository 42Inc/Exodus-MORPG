class UsersController < ApplicationController
  attr_accessor :name, :email
  public
    def initialize
      super
      @controller = "Users"
      @page = "Default"
    end

    def show
      @page = "User"
      @user = User.find(params[:id])
    end

    def new
      @page = "New"
      @user = User.new
    end

    def index
      @page = "Users"
    end

    def create
      @page = "Create"
      @user = User.new(params_for_user)
      if @user.save
        redirect_to @user
      else
        render 'new'
      end
    end

    def edit
      @page = "Edit"
    end

    def update
      @page = "Update"
    end

    def destroy
      @page = "Delete"
    end

  private
    def params_for_user
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
