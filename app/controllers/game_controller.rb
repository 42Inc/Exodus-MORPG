class GameController < ApplicationController
  def initialize
    @controller = "Server"
    @page = "Default"
  end

  def aboutgame
    @page = "About"
  end
end
