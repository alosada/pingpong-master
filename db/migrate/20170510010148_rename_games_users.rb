class RenameGamesUsers < ActiveRecord::Migration
  def change
    rename_table :games_users, :game_users
  end
end
