FactoryGirl.define do
  factory :user do
    name ['Brian Jones', 'Jimi Hendrix', 'Janis Joplin', 'Jim Morrison', 'Kurt Cobain', 'Amy Winehouse'].sample
    email "#{['Brian Jones', 'Jimi Hendrix', 'Janis Joplin', 'Jim Morrison', 'Kurt Cobain', 'Amy Winehouse'].sample.gsub(' ', '')}#{Time.now.to_s}@fake.com"
    password 'pass123456789'
  end

  factory :game do
    date_of_game  Time.now
    score  { {winner: 21, looser: 18}.to_json }

    transient do
      user_count 2
    end

    after(:create) do |user, evaluator|
      create_list(:user, evaluator.user_count, game: game)
    end
    
    factory :game_bad_score do
      score { {winner: 21, looser: 20}.to_json }
    end
  end
  
end
