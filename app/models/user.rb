class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :trackable, :validatable
  has_many :game_users
  has_many :games, through: :game_users

  def self.update_ranks
    order(score: :desc).each_with_index do |user, index|
      user.rank =
        if user.games.count == 0
          'N/A'
        else
          index + 1
        end
      user.save
    end
  end

end
