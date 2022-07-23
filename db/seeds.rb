# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'
require 'faker'
require "open-uri"

User.destroy_all
Visit.destroy_all
Lock.destroy_all
Review.destroy_all

file1 = URI.open("https://i.pravatar.cc/100?img=#{rand(70)}")
file2 = URI.open("https://i.pravatar.cc/100?img=#{rand(70)}")


csv_text = File.read(Rails.root.join('lib', 'seeds', 'seed.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')

review_rating = [
  ["This lock changed my life", 5],
  ["What a cool lock, I really loved it", 4],
  ["I am going to tell all my friends about this lock", 5],
  ["I really like this place, very cute", 5],
  ["Wow, this is the best location ever!", 4],
  ["After visiting this lock I see the world differently. its amazing", 5],
  ["When I got here my boyfriend proposed to me!", 5],
  ["I wish I could give this lock 10,0000 stars", 5],
  ["Life changing experince. I will never see melbourne the same way again", 5],
  ["Great location!", 3],
  ["meh, a little overwhelming", 3],
  ["This lock sucked!", 2],
  ["I would like a refund... oh wait, I didnt pay for this... but still.. give me a refund!", 2],
  ["a seagull did a doo doo on this so it was a little icky", 1]
]

csv.each do |row|
  t = Lock.new

  t.name = row['Name']
  t.address = row['Address']
  t.description = row['Description']
  t.special_content = row['Special_Content']
  t.lock_type = row['Lock_type']
  photo = URI.open(row['Photo'])
  t.photo.attach(io: photo, filename: 'profile.jpg', content_type: 'image/jpg')
  t.status = "Accepted"
  t.save
end

beth = User.create!(email: "beth@gmail.com", password: "password", username: "Bethany", admin: "true")
beth.photo.attach(io: file1, filename: 'profile.jpg', content_type: 'image/jpg')
locks = Lock.all
lock_id = []
locks.each do |lock|
  lock_id << lock.id
end

rand(44).times do
  lock = Lock.find_by(id: lock_id[1])
  lock_photo = URI.open(lock.photo.url)
  visit = Visit.create!(user_id: beth.id, lock_id: lock_id[1], unlocked_date: DateTime.now)
  lock_id.rotate!
  review = review_rating.sample
  Review.create!(rating: review[1], comment: review[0], visit_id: visit.id, user_id: beth.id)
  visit.photo.attach(io: lock_photo, filename: 'profile.jpg', content_type: 'image/jpg')
end

15.times do
  user = User.create!(email: Faker::Internet.unique.email, password: "password", username: Faker::FunnyName.unique.two_word_name, admin: "false")
  file = URI.open("https://i.pravatar.cc/100?img=#{rand(70)}")
  user.photo.attach(io: file, filename: 'profile.jpg', content_type: 'image/jpg')
  rand(44).times do
    lock_two = Lock.find_by(id: lock_id[1])
    lock_photo = URI.open(lock_two.photo.url)
    visit_two = Visit.create!(user_id: user.id, lock_id: lock_id[1], unlocked_date: DateTime.now)
    lock_id.rotate!
    review = review_rating.sample
    Review.create!(rating: review[1], comment: review[0], visit_id: visit_two.id, user_id: user.id)
    rand(0..1).times do
      rand(0..1).times do
        rand(0..1).times do
          visit_two.photo.attach(io: lock_photo, filename: 'profile.jpg', content_type: 'image/jpg')
        end
      end
    end
  end
end

pending_lock = Lock.create!(name: "Glorious Pot Hole", address: "Melbourne, 3000",
              description: "This Pot hole has been here for 2 months and is now a part of Melbourne!",
              special_content:"send an email to the council and you win a taco",
              lock_type: "nature walk", status:"Pending")

pending_photo = URI.open("https://wpcdn.us-east-1.vip.tn-cloud.net/www.kxly.com/content/uploads/2022/01/j/e/pothole-e1641582427324-1024x576.jpg")
pending_lock.photo.attach(io: pending_photo, filename: 'profile.jpg', content_type: 'image/jpg')
