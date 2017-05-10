class GamesUsers < ActiveRecord::Base
  has_many :games
  has_many :users
end