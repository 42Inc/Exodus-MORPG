class UsersController < ApplicationController
  def initialize
    super
    @controller = "Users"
    @page = "Default"
  end

  def new
    @page = "New"
  end
end
