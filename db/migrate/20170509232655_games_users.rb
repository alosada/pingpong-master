class GamesUsers < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.refereces :user
      t.refereces :game
    end
  end
end
