require "rails_helper"

RSpec.describe Game, :type => :model do
  it "checks that the score " do
    game = build(:game)
    game.stub(:set_score) { true }
    expect(game.save).to be true
    game = build(:game, score_json: {winner: 21, looser: 20}.to_json)
    game.stub(:set_score) { true }
    expect(game.save).to be false
  end

  it "score_to_s" do
    game = build(:game)
    expect(game.score_to_s).to match(/\d+ to \d+/)
  end
end