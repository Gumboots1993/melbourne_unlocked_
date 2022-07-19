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
larry = URI.open("https://res.cloudinary.com/druyptave/image/upload/v1658154568/development/larry_ev7x4h.jpg")

csv_text = File.read(Rails.root.join('lib', 'seeds', 'seed.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')


csv.each do |row|
  t = Lock.new

  t.name = row['Name']
  t.address = row['Address']
  t.description = row['Description']
  t.photo.attach(io: larry, filename: 'profile.jpg', content_type: 'image/jpg')
  t.save
end

beth = User.create!(email: "beth@gmail.com", password: "password", username: "Bethany")
beth.photo.attach(io: file1, filename: 'profile.jpg', content_type: 'image/jpg')
moo = User.create!(email: "moo@gmail.com", password: "password", username: "Mooletta")
moo.photo.attach(io: file2, filename: 'profile.jpg', content_type: 'image/jpg')
street = ["Flinders St VIC 3000", "Collins St VIC 3000", "La Trobe Street VIC 3000", "Lonsdale St VIC 3000"]
locks = Lock.all
lock_id = []
locks.each do |lock|
  lock_id << lock.id
end

11.times do
  Visit.create!(user_id: beth.id, lock_id: lock_id[1], unlocked_date: DateTime.new(2001,2,3,4,5,6,'+03:00'))
  lock_id.rotate!
end

10.times do
  Visit.create!(user_id: moo.id, lock_id: lock_id[1], unlocked_date: DateTime.new(2001,2,3,4,5,6,'+03:00'))
  lock_id.rotate!
end

25.times do
  user = User.create!(email: Faker::Internet.unique.email, password: "password", username: Faker::FunnyName.unique.two_word_name)
  file = URI.open("https://i.pravatar.cc/100?img=#{rand(70)}")
  user.photo.attach(io: file, filename: 'profile.jpg', content_type: 'image/jpg')
  rand(10).times do
    Visit.create!(user_id: user.id, lock_id: lock_id[1], unlocked_date: DateTime.new(2001,2,3,4,5,6,'+03:00'))
    lock_id.rotate!
  end
end
