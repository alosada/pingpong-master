class Game < ActiveRecord::Base
  has_many :game_users
  has_many :users, through: :game_users
  belongs_to :winner, class_name: 'User', foreign_key: 'user_id'
  before_save :set_score, :update_rank
  validate :score_diference_greater_than_two

  def opponent(current_user)
    users.where.not(id: current_user.id).first
  end

  def score_to_s
    "#{score['winner']} to #{score['looser']}" 
  end

  def score
    JSON.parse(score)
  end

  def result(current_user)
    return 'Won' if winner = current_user
    'Lost'
  end

  def looser
    looser_id = GameUser.where(game_id: id).pluck(:user_id) - [user_id]
    User.find(looser_id.first)
  end

  def opponent(current_user)
    users.where.not(id: current_user.id).first
  end

  private

  def score_diference
    sscore['winner'].to_i - sscore['looser'].to_i
  end
    
  def set_score
    multiplier = looser.rank.to_i - winner.rank.to_i
    winner.score +=
      if multiplier > 0
        100*multiplier
      else
        100
      end
    winner.save
  end

  def score_diference_greater_than_two
    errors.add(:score, "Margin is lesser than 2 points") unless score_diference >= 2
  end

  def update_rank #candidate for BG worker
    User.order(score: :desc).each_with_index do |user, index|
      user.rank = index + 1
      user.save
    end
  end
end

# Games follow standard ping pong rules. They are games to 21. Each game needs to be won by a two point margin.