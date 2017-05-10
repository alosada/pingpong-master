
if User.count.zero?
  ['inigo', 'edrizio'].each do |u|
    User.create!(email: "#{u}@regalii.com", password: 'secret123')
  end
  puts "-- Added 2 users to your database"
  User.create!(email: 'alosada@gmail.com', password: 'Regalii2017')
end

User.all.each do |u|
  u.name =
    if u.email == 'alosada@gmail.com'
      'Alejandro'
    else
      ['Brian Jones', 'Jimi Hendrix', 'Janis Joplin', 'Jim Morrison', 'Kurt Cobain', 'Amy Winehouse'].sample
    end
  u.save
end
