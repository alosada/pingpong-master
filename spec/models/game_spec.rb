require "rails_helper"

RSpec.describe Game, :type => :model do
  it 'checks that the score' do
    game = build(:game)
    game.stub(:set_score) { true }
    expect(game.save).to be true
    game = build(:game_bad_score)
    game.stub(:set_score) { true }
    expect(game.save).to be false
  end

  it '#score_to_s' do
    game = build(:game)
    expect(game.score_to_s).to match(/\d+ to \d+/)
  end

  it '#opponent' do
    game = build(:game)
    2.times {game.users << create(:user)}
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
    expect(game.won?(create(:user))).to be false
  end
end

#   def score
#     JSON.parse(score_json)
#   end

#   def result(current_user)
#     return 'Won' if winner = current_user
#     'Lost'
#   end

#   def looser
#     looser_id = GameUser.where(game_id: id).pluck(:user_id) - [user_id]
#     User.find(looser_id.first)
#   end

#   def opponent(current_user)
#     users.where.not(id: current_user.id).first
#   end

#   private

#   def score_diference
#     score['winner'].to_i - score['looser'].to_i
#   end
    
#   def set_score
#     multiplier = looser.rank.to_i - winner.rank.to_i
#     winner.score +=
#       if multiplier > 0
#         100*multiplier
#       else
#         100
#       end
#     winner.save
#   end

#   def score_diference_greater_than_two
#     errors.add(:score, "Margin is lesser than 2 points") unless score_diference >= 2
#   end

#   def update_rank #candidate for BG worker
#     User.order(score: :desc).each_with_index do |user, index|
#       user.rank = index + 1
#       user.save
#     end
#   end