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

  # PATCH/PUT /games/1
  def update
    if @game.update(game_params)
      redirect_to @game, notice: 'Game was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /games/1
  def destroy
    @game.destroy
    redirect_to games_url, notice: 'Game was successfully destroyed.'
  end

  private
    # Only allow a trusted parameter "white list" through.
    def game_params
      params[:game][:score] = {winner: params['game']['win'], looser: params['game']['loose']}.to_json
      params[:game][:user_id] = 
      if params[:game][:winner] == '1'
        current_user.id
      else
        params[:game][:opponent]
      end
      params[:game][:date_of_game] = Date.new(params['game']['date_of_game(1i)'].to_i,
                                              params['game']['date_of_game(2i)'].to_i,
                                              params['game']['date_of_game(3i)'].to_i
                                              )
      params.require(:game).permit(:date_of_game, :user_id, :score)
    end
end
