require "rails_helper"

RSpec.describe User, :type => :model do
  it '#update_ranks' do
    create(:user, score: 0)
    5.times do
      user = create(:user)
      game = build(:game)
      game.stub(:set_score) { true }
      game.stub(:update_rank) { User.all }
      user.games << game
    end
    
    users = User.update_ranks
    expect(users.first.rank).to eq(1.to_s)
    expect(users.last.rank).to eq('N/A')
    expect(users.last.score).to eq(0)
  end
end
