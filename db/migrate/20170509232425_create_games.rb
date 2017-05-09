class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.datetime :date_of_game
      t.refereces :user
      t.string :score
      t.timestamps null: false
    end
  end
end
