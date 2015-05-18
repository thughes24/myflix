# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Comedy = Category.create(name: "Comedy")
Drama = Category.create(name: "Drama")
Video.create(title: "Futurama", description: "Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.", small_cover_url: "/tmp/futurama.jpg", large_cover_url: "/tmp/futurama.jpg", category: Drama)
Video.create(title: "Monk", description: "I don't know much about monk, I've heard it's great though!", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", category: Comedy)
Video.create(title: "Family Guy", description: "Family guy is a funny show!", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "/tmp/family_guy.jpg", category: Comedy)
Video.create(title: "South Park", description: "South Park is the best of the lot!", small_cover_url: "/tmp/south_park.jpg", large_cover_url: "/tmp/south_park.jpg", category: Comedy)
User.create(username: "demo", password: "password", email: "demo@example.com")