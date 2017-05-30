FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    score { 100*rand(1..9) }
    password 'pass123456789'
  end

  factory :game do
    date_of_game  Time.now
    score_json  { {winner: 21, looser: 18}.to_json }
  
    before(:create) do |game|
      game.winner = create(:user)
      game.users << game.winner
      game.users << create(:user)
      game.stub(:update_rank) { User.all }
    end

    after(:build) do |game|
      game.stub(:update_rank) { User.all }
    end
    
    factory :game_bad_score do
      score_json { {winner: 21, looser: 20}.to_json }
    end
  end
  
end
