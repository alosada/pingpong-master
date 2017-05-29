require "rails_helper"

RSpec.describe Game, :type => :model do
  it 'checks that the score diference is bigger than 2' do
    game = build(:game)
    game.stub(:set_score) { true }
    game.stub(:update_rank) { User.all }
    expect(game.save).to be true
    game = build(:game_bad_score)
    game.stub(:set_score) { true }
    game.stub(:update_rank) { User.all }
    expect(game.save).to be false
  end

  it '#score_to_s' do
    game = build(:game)
    expect(game.score_to_s).to match(/\d+ to \d+/)
  end

  it '#opponent' do
    game = build(:game)
    2.times {game.users << build(:user)}
    game.winner = game.users.last
    expect(game.opponent(game.winner)).not_to  eq(game.winner)
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
    user  = create(:user)
    game = build(:game)
    game.winner = user
    expect(game.result(user)).to match('Won')
    expect(game.result(build(:user))).to match('Lost')
  end

  it '#looser' do
    game = build(:game)
    game.stub(:set_score) { true }
    game.stub(:update_rank) { User.all }
    2.times { game.users << create(:user) }
    game.winner = game.users.last
    game.save
    expect(game.looser).not_to eq(game.winner)
  end
end
