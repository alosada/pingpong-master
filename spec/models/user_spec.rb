require "rails_helper"

RSpec.describe User, :type => :model do
  it '#update_ranks' do
    create(:user, score: 0)
    5.times do
      user = create(:user)
      game = create(:game)
      user.games << game
    end
    
    users = User.update_ranks
    expect(users.first.rank).to eq('1')
    expect(users[1].rank).to eq('2')
    expect(users.last.rank).to eq('N/A')
    expect(users.last.score).to eq(0)
  end
end
