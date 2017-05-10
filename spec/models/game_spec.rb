require "rails_helper"

RSpec.describe Game, :type => :model do
  it "checks that the score " do
    # game = build(:game)
    game = Game.create!(date_of_game: Date.today, score: {winner: 21, looser: 15}.to_json, winner: create(:user))
    user = build(:user)
    game.winner = user
    game.users << user
    game.users << build(:user)
    expect(game.save).to be_true
    # game = build(:game_bad_score)
    game = Game.create!(date_of_game: Date.today, score: {winner: 21, looser: 20}.to_json, winner: create(:user))
    game.winner = build(:user)
    expect(game.save).to be_false
  end

  it "points" do
    # game = create(:game)
    game = Game.create!(date_of_game: Date.today, score: {winner: 21, looser: 15}.to_json, winner: create(:user))
    game.winner = build(:user)
    expect(game.points).to be_a(Integer)
  end

  # need method to make sure looser score is not greater than winner score

end