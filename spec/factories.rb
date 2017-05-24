FactoryGirl.define do
  factory :user do
    name ['Brian Jones', 'Jimi Hendrix', 'Janis Joplin', 'Jim Morrison', 'Kurt Cobain', 'Amy Winehouse'].sample
    email "#{['Brian Jones', 'Jimi Hendrix', 'Janis Joplin', 'Jim Morrison', 'Kurt Cobain', 'Amy Winehouse'].sample}@#{Time.now.to_s}.com".gsub(' ', '').downcase
    password 'pass123456789'
  end

  factory :game do
    date_of_game  Time.now
    score_json  { {winner: 21, looser: 18}.to_json }

    after(:create) do |user, evaluator|
      create_list(:user, 2, game: game)
      self.winner = self.users.first
    end
    
    factory :game_bad_score do
      score_json { {winner: 21, looser: 20}.to_json }
    end
  end
  
end
