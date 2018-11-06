class UsersController < ApplicationController
  attr_accessor :name, :email
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
end
