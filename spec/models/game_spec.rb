require "rails_helper"

RSpec.describe Game, :type => :model do

  it 'has a valid factory' do
    create(:game).should be_valid
  end

  it 'checks that the score diference is bigger than 2' do
    game = build(:game)
    expect(game.save).to be true
    game = build(:game_bad_score)
    expect(game.save).to be false
  end

  it '#score_to_s' do
    game = create(:game)
    expect(game.score_to_s).to match(/\d+ to \d+/)
  end

  it '#opponent' do
    game = create(:game)
    expect(game.opponent(game.winner)).to be_a User
    expect(game.opponent(game.winner)).not_to eq(game.winner)
  end

  it '#score' do
    game = build(:game)
    expect(game.score).to be_a Hash
    expect(game.score['winner']).to be_a Integer
    expect(game.score['looser']).to be_a Integer
  end

  it '#won?' do
    user  = create(:user)
    game = build(:game)
    game.winner = user
    expect(game.won?(user)).to be true
    expect(game.won?(build(:user))).to be false
  end

  it '#result' do
    game = create(:game)
    expect(game.result(game.winner)).to match('Won')
    expect(game.result(game.looser)).to match('Lost')
  end

  it '#looser' do
    game = create(:game)
    expect(game.looser).to be_a User
    expect(game.looser).not_to eq(game.winner)
  end

  # it 'sets the score'
end
