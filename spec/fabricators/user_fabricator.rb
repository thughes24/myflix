Fabricator(:user) do
  username { Faker::Lorem.words(2).join(" ")}
  email { Faker::Internet.email }
  password { Faker::Lorem.words(3).join(" ")}
end