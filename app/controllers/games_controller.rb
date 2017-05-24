class GamesController < ApplicationController
  # POST /games
  def create
    @game = Game.new(game_params)
    @game.users << current_user
    @game.users << User.find(params['game']['opponent'])
    if @game.save
      redirect_to root_path
    else
      redirect_to back
    end
  end

  private

    def game_params
      params[:game][:date_of_game] = set_date
      params[:game][:score_json] = set_score_json
      params[:game][:user_id] = resolve_winner
      params.require(:game).permit(:date_of_game, :user_id, :score_json)
    end

    def set_date
      Date.new(params['game']['date_of_game(1i)'].to_i,
               params['game']['date_of_game(2i)'].to_i,
               params['game']['date_of_game(3i)'].to_i)
    end

    def set_score_json
      {winner: params['game']['win'], looser: params['game']['loose']}.to_json
    end

    def resolve_winner
      if params[:game][:winner] == '1'
        current_user.id
      else
        params[:game][:opponent]
      end
    end

end
