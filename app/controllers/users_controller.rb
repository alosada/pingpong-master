class UsersController < ApplicationController
  def index
    @users = User.order(:rank).map do |user|
      [user.rank, user.name, user.score, user.games.count]
    end
    render json: @users
  end
end
