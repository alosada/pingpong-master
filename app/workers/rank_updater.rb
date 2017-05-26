class RankUpdater
  include Sidekiq::Worker
  def perform
    User.update_ranks
  end
end