comedy = Category.create(name: "Comedy")
drama = Category.create(name: "Drama")

futurama = Video.create(title: "Futurama", description: "Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.", small_cover_url: "/tmp/futurama.jpg", large_cover_url: "/tmp/futurama.jpg", category: drama)
monk = Video.create(title: "Monk", description: "I don't know much about monk, I've heard it's great though!", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", category: comedy)
family_guy = Video.create(title: "Family Guy", description: "Family guy is a funny show!", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "/tmp/family_guy.jpg", category: comedy)
south_park = Video.create(title: "South Park", description: "South Park is the best of the lot!", small_cover_url: "/tmp/south_park.jpg", large_cover_url: "/tmp/south_park.jpg", category: comedy)

demo_user = User.create(username: "demo", password: "password", email: "demo@example.com")
other_user = User.create(username: 'other', password: 'password', email: 'email@example.com')
admin_user = User.create(username: 'admin', password: 'password', email: 'admin@example.com', admin: true)

review1 = Review.create(rating: 4, writeup: "this show is good, i give it 4", user: demo_user, video: monk)
review2 = Review.create(rating: 2, writeup: "this show is bad, i give it 2", user: demo_user, video: futurama)
review3 = Review.create(rating: 5, writeup: "this show is great, i give it 5", user: demo_user, video: monk)

review4 = Review.create(rating: 4, writeup: "this show is good, i give it 4, i'm the other user, bitch", user: other_user, video: monk)
review5 = Review.create(rating: 2, writeup: "this show is bad, i give it 2, i'm the other user, bitch", user: other_user, video: futurama)
review6 = Review.create(rating: 5, writeup: "this show is great, i give it 5, i'm the other user, bitch", user: other_user, video: monk)
queue_item1 = QueueItem.create(user: demo_user, video: futurama, position: 1)
queue_item2 = QueueItem.create(user: demo_user, video: south_park, position: 2)

queue_item3 = QueueItem.create(user: other_user, video: monk, position: 1)
queue_item4 = QueueItem.create(user: other_user, video: south_park, position: 2)

follow1 = Follow.create(user: demo_user, following: other_user)
follow2 = Follow.create(user: other_user, following: demo_user)



