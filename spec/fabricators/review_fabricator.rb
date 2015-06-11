Fabricator(:review) do
  rating {rand(1..5)}
  writeup { Faker::Lorem::words(2).join(' ') }
end