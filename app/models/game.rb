class Game < ActiveRecord::Base
  has_many :game_users
  has_many :users, through: :game_users
  belongs_to :winner, class_name: 'User', foreign_key: 'user_id'
  after_create :set_score, :update_rank
  validate :score_diference_greater_than_two, :correct_number_of_players

  def opponent(current_user)
    users.where.not(id: current_user.id).first
  end

  def score_to_s
    "#{score['winner']} to #{score['looser']}" 
  end

  def score
    JSON.parse(score_json)
  end

  def won?(current_user)
    winner == current_user
  end

  def result(current_user)
    return 'Won' if won?(current_user)
    'Lost'
  end

  def looser
    users.where.not(id: user_id).first
  end

  def correct_number_of_players?
    users.length == 2
  end

  private

  def multiplier
    m = winner.rank.to_i - looser.rank.to_i 
    return 1 if m <= 0
    m
  end

  def score_diference
    score['winner'].to_i - score['looser'].to_i
  end
    
  def set_score
    winner.score += 100*multiplier
    winner.save
  end

  def score_diference_greater_than_two
    errors.add(:score, 'Margin is lesser than 2 points.') unless score_diference >= 2
  end

  def correct_number_of_players
    errors.add(:players, "A game need 2 players. player count : #{users.count}") unless correct_number_of_players?
  end

  def update_rank
    RankUpdater.perform_async
  end
end

# Games follow standard ping pong rules. They are games to 21. Each game needs to be won by a two point margin.