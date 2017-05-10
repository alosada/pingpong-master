require "rails_helper"

RSpec.describe Game, :type => :model do
  it "checks that the score " do
    game = build(:game)
    game.winner = build(:user)
    expect(game.save).to be_true
    game = build(:game_bad_score)
    game.winner = build(:user)
    expect(game.save).to be_false
  end

  it "points" do
    game = create(:game)
    game.winner = build(:user)
    expect(game.points).to be_a(Integer)
  end
end