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
    s = JSON.parse(score)
    "#{s['winner']} to #{s['looser']}" 
  end

  def result(current_user)
    if winner = current_user
      'Won'
    else
      'Lost'
    end
  end

  private

  def set_score # needs refactor
    w = winner.id
    l = users.map{|u| u.id} - [w]
    l = User.find(l.first)
    multiplier = winner.rank.to_i - l.rank.to_i
    winner.score +=
      if multiplier > 0
        100*multiplier
      else
        100
      end
    winner.save
  end

  def score_diference_greater_than_two
    s = JSON.parse(score)
    errors.add(:score, "Margin is lesser than 2 points") unless s['winner'].to_i - s['looser'].to_i >= 2
  end

  def update_rank #candidate for BG worker
    User.order(score: :desc).each_with_index do |user, index|
      user.rank = index + 1
      user.save
    end
  end

  def opponent(current_user)
    users.where.not(id: current_user.id).first
  end
end

# Games follow standard ping pong rules. They are games to 21. Each game needs to be won by a two point margin.