# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'
require 'faker'

User.destroy_all
Visit.destroy_all
Lock.destroy_all
Review.destroy_all

csv_text = File.read(Rails.root.join('lib', 'seeds', 'seed.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')

csv.each do |row|
  t = Lock.new

  t.name = row['Name']
  t.address = row['Address']
  t.description = row['Description']

  t.save
end

beth = User.create!(email: "beth@gmail.com", password: "password", username: "Bethany", photo: "https://i.pravatar.cc/100?img=#{rand(70)}")
moo = User.create!(email: "moo@gmail.com", password: "password", username: "Mooletta", photo: "https://i.pravatar.cc/100?img=#{rand(70)}")
street = ["Flinders St VIC 3000", "Collins St VIC 3000", "La Trobe Street VIC 3000", "Lonsdale St VIC 3000"]
locks = Lock.all
lock_id = []
locks.each do |lock|
  lock_id << lock.id
end

11.times do
  Visit.create!(user_id: beth.id, lock_id: lock_id[1], photo:"https://live.staticflickr.com/7581/15927731828_149cb4acee_b.jpg", unlocked_date: DateTime.new(2001,2,3,4,5,6,'+03:00'))
  lock_id.rotate!
end

10.times do
  Visit.create!(user_id: moo.id, lock_id: lock_id[1], photo:"https://live.staticflickr.com/7581/15927731828_149cb4acee_b.jpg", unlocked_date: DateTime.new(2001,2,3,4,5,6,'+03:00'))
  lock_id.rotate!
end

25.times do
  user = User.create!(email: Faker::Internet.unique.email, password: "password", username: Faker::FunnyName.unique.two_word_name, photo: "https://i.pravatar.cc/100?img=#{rand(70)}")
  rand(10).times do
    Visit.create!(user_id: user.id, lock_id: lock_id[1], photo:"https://live.staticflickr.com/7581/15927731828_149cb4acee_b.jpg", unlocked_date: DateTime.new(2001,2,3,4,5,6,'+03:00'))
    lock_id.rotate!
  end
end
