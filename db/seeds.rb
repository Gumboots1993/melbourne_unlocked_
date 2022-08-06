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
require "mini_magick"

User.destroy_all
Visit.destroy_all
Lock.destroy_all
Review.destroy_all

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

people = [
  File.join(Rails.root,'app/assets/images/people/person_1.png'),
  File.join(Rails.root,'app/assets/images/people/person_2.png'),
  File.join(Rails.root,'app/assets/images/people/person_3.png'),
  File.join(Rails.root,'app/assets/images/people/person_4.png'),
  File.join(Rails.root,'app/assets/images/people/person_5.png'),
  File.join(Rails.root,'app/assets/images/people/person_6.png'),
  File.join(Rails.root,'app/assets/images/people/person_7.png'),
  File.join(Rails.root,'app/assets/images/people/person_8.png'),
  File.join(Rails.root,'app/assets/images/people/person_9.png'),
  File.join(Rails.root,'app/assets/images/people/person_10.png'),
  File.join(Rails.root,'app/assets/images/people/person_11.png'),
  File.join(Rails.root,'app/assets/images/people/person_12.png'),
  File.join(Rails.root,'app/assets/images/people/person_13.png'),
  File.join(Rails.root,'app/assets/images/people/person_14.png'),
  File.join(Rails.root,'app/assets/images/people/person_15.png')
]

def levels(user)
  visits = user.visits.count
  case visits
  when 0..4
    "LVL 0 NOVICE"
  when 5..9
    "LVL 1 LEARNER"
  when 10..19
    "LVL 2 EXPERT"
  when 20..29
    "LVL 3 MASTER"
  when 30..39
    "LVL 4 DIVINE"
  else
    "LVL 5 SUPREME"
  end
end

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

molly_lock = Lock.create!(name: "Molly Meldrum Statue",
  address:"Stewart St Reserve, Richmond VIC 3121",
  description: "A larger-than-life bronze statue of local music identity Ian ‘Molly’ Meldrum AM stands with his beloved dog Ziggy by his side",
  special_content: "Molly's original hat was a \"Billy the Kid\" Stetson which Lindsay Fox brought back for him from Texas. Now there's a place in Brisbane that makes them for him. He has said he goes through about 20 a year.",
  lock_type: "Statue",
  status: "Accepted")

molly_photo = URI.open("https://arts.yarracity.vic.gov.au/-/media/all-images/unfiled-images-1/molly-by-nicole-cleary.jpg")
molly_lock.photo.attached(io: molly_photo, filename: 'profile.jpg', content_type: 'image/jpg')
molly_lock.latitude = -37.82460421892059
molly_lock.longitude = 144.99230931768986
molly_lock.save

locks = Lock.all
lock_id = []
locks.each do |lock|
  lock_id << lock.id
end


file1 = File.open(File.join(Rails.root,'app/assets/images/beth.jpg'))
beth = User.create!(email: "beth@gmail.com", password: "password", username: "Bethany", admin: "true")
beth.photo.attach(io: file1, filename: 'profile.jpg', content_type: 'image/jpg')
WelcomeNotification.with(user: beth.id).deliver(beth)

rand(44).times do
  lock = Lock.find_by(id: lock_id[1])
  lock_photo_url = lock.photo.url
  lock_photo = URI.open(lock_photo_url)
  visit = Visit.create!(user_id: beth.id, lock_id: lock_id[1], unlocked_date: DateTime.now)
  lock_id.rotate!

  true_or_false = Faker::Boolean.boolean(true_ratio: rand(0.9))
  next if true_or_false

  review = review_rating.sample
  Review.create!(rating: review[1], comment: review[0], visit_id: visit.id, user_id: beth.id)

  second_image = MiniMagick::Image.open(people[0])
  first_image = MiniMagick::Image.open(lock_photo_url)
  first_image.resize "500x500"
  first_image.write("logo.jpg")
  second_image.resize "500x500"
  second_image.write("beth2.jpg")
  result = first_image.composite(second_image) do |c|
    c.compose "Over"    # OverCompositeOp
    c.gravity "center"
  end
  result.write "output.jpg"
  compo_photo = URI.open(result.path)

  visit.photo.attach(io: compo_photo, filename: 'profile.jpg', content_type: 'image/jpg')
end
beth.level = levels(beth)
beth.save

15.times do
  user = User.create!(email: Faker::Internet.unique.email, password: "password", username: Faker::FunnyName.unique.two_word_name, admin: "false")
  file = URI.open("https://i.pravatar.cc/100?img=#{rand(70)}")
  user.photo.attach(io: file, filename: 'profile.jpg', content_type: 'image/jpg')
  WelcomeNotification.with(user: user.id).deliver(user)
  people.rotate!
  rand(44).times do
    lock = Lock.find_by(id: lock_id[1])
    lock_photo_url = lock.photo.url
    lock_photo = URI.open(lock_photo_url)
    visit = Visit.create!(user_id: user.id, lock_id: lock_id[1], unlocked_date: DateTime.now)
    lock_id.rotate!

    true_or_false = Faker::Boolean.boolean(true_ratio: rand(0.5))
    next if true_or_false

    review = review_rating.sample
    Review.create!(rating: review[1], comment: review[0], visit_id: visit.id, user_id: user.id)

    second_image = MiniMagick::Image.open(people[0])
    first_image = MiniMagick::Image.open(lock_photo_url)
    first_image.resize "500x500"
    first_image.write("logo.jpg")
    second_image.resize "500x500"
    second_image.write("beth2.jpg")

    result = first_image.composite(second_image) do |c|
      c.compose "Over"    # OverCompositeOp
      c.gravity "center"
    end
    result.write "output.jpg"

    compo_photo = URI.open(result.path)
    visit.photo.attach(io: compo_photo, filename: 'profile.jpg', content_type: 'image/jpg')
  end
  user.level = levels(user)
  user.save
end



pending_lock = Lock.create!(name: "Glorious Pot Hole", address: "Melbourne, 3000",
              description: "This Pot hole has been here for 2 months and is now a part of Melbourne!",
              special_content:"send an email to the council and you win a taco",
              lock_type: "nature walk", status:"Pending")

pending_photo = URI.open("https://wpcdn.us-east-1.vip.tn-cloud.net/www.kxly.com/content/uploads/2022/01/j/e/pothole-e1641582427324-1024x576.jpg")
pending_lock.photo.attach(io: pending_photo, filename: 'profile.jpg', content_type: 'image/jpg')
