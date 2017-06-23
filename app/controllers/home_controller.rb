class HomeController < ApplicationController
  def index
    @users = User.order(:rank)
  end

  def log
    @game = Game.new
  end
end
