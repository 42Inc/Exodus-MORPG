class UsersController < ApplicationController
  attr_accessor :name, :email
  def initialize
    super
    @controller = "Users"
    @page = "Default"
  end

  def new
    @page = "New"
  end
end
