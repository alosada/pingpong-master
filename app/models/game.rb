class Game < ActiveRecord::Base
  has_many :games_users
  has_many :users, through: :games_users
end

# Games follow standard ping pong rules. They are games to 21. Each game needs to be won by a two point margin.