# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

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

user = User.create!(email: "beth@gmail.com", password: "password", username: "bethrox4eva", photo: "https://live.staticflickr.com/7581/15927731828_149cb4acee_b.jpg")
user2 = User.create!(email: "moo@gmail.com", password: "password", username: "Betty", photo: "https://live.staticflickr.com/7581/15927731828_149cb4acee_b.jpg" )
user3 = User.create!(email: "user3@gmail.com", password: "password", username: "bob", photo: "https://live.staticflickr.com/7581/15927731828_149cb4acee_b.jpg")
user4 = User.create!(email: "user4@gmail.com", password: "password", username: "angela", photo: "https://live.staticflickr.com/7581/15927731828_149cb4acee_b.jpg")
user5 = User.create!(email: "user5@gmail.com", password: "password", username: "roxy", photo: "https://live.staticflickr.com/7581/15927731828_149cb4acee_b.jpg")
user6 = User.create!(email: "user6@gmail.com", password: "password", username: "fred", photo: "https://live.staticflickr.com/7581/15927731828_149cb4acee_b.jpg")
user7 = User.create!(email: "user7@gmail.com", password: "password", username: "harry", photo: "https://live.staticflickr.com/7581/15927731828_149cb4acee_b.jpg")
user8 = User.create!(email: "user8@gmail.com", password: "password", username: "george", photo: "https://live.staticflickr.com/7581/15927731828_149cb4acee_b.jpg")
user9 = User.create!(email: "user9@gmail.com", password: "password", username: "leo", photo: "https://live.staticflickr.com/7581/15927731828_149cb4acee_b.jpg")
street = ["Flinders St VIC 3000", "Collins St VIC 3000", "La Trobe Street VIC 3000", "Lonsdale St VIC 3000"]


4.times do
  lock = Lock.create!(address: "#{rand(300)} #{street.sample}" , description: "a cool location that has many cool features", image: "https://4.bp.blogspot.com/-Vw_M7aTMY44/VzClQb44aCI/AAAAAAAAAto/e3Dk5LFkfsAcim4Dw0qC9bpRg48wIDaXACLcB/s1600/IMG_4626.JPG", special_content: "did you know I am the coolest statue in melbourne", lock_type: "statue", name: "Larry La Trobe", status: "true")
  Visit.create!(user_id: user.id, lock_id: lock.id, photo:"https://live.staticflickr.com/7581/15927731828_149cb4acee_b.jpg", unlocked_date: DateTime.new(2001,2,3,4,5,6,'+03:00'))
  Review.create!(rating: rand(5), comment: "best location ever!", user_id: user.id)
end

3.times do
  lock = Lock.create!(address: "#{rand(300)} #{street.sample}" , description: "a cool location that has many cool features", image: "https://4.bp.blogspot.com/-Vw_M7aTMY44/VzClQb44aCI/AAAAAAAAAto/e3Dk5LFkfsAcim4Dw0qC9bpRg48wIDaXACLcB/s1600/IMG_4626.JPG", special_content: "did you know I am the coolest statue in melbourne", lock_type: "statue", name: "The library", status: "true")
  Visit.create!(user_id: user2.id, lock_id: lock.id, photo:"https://live.staticflickr.com/7581/15927731828_149cb4acee_b.jpg", unlocked_date: DateTime.new(2001,2,3,4,5,6,'+03:00'))
  Review.create!(rating: rand(5), comment: "best location ever!", user_id: user2.id)
end

2.times do
  lock = Lock.create!(address: "#{rand(300)} #{street.sample}" , description: "a cool location that has many cool features", image: "https://4.bp.blogspot.com/-Vw_M7aTMY44/VzClQb44aCI/AAAAAAAAAto/e3Dk5LFkfsAcim4Dw0qC9bpRg48wIDaXACLcB/s1600/IMG_4626.JPG", special_content: "did you know I am the coolest statue in melbourne", lock_type: "statue", name: "The library", status: "true")
  Visit.create!(user_id: user3.id, lock_id: lock.id, photo:"https://live.staticflickr.com/7581/15927731828_149cb4acee_b.jpg", unlocked_date: DateTime.new(2001,2,3,4,5,6,'+03:00'))
  Review.create!(rating: rand(5), comment: "best location ever!", user_id: user3.id)
end

  lock = Lock.create!(address: "#{rand(300)} #{street.sample}" , description: "a cool location that has many cool features", image: "https://4.bp.blogspot.com/-Vw_M7aTMY44/VzClQb44aCI/AAAAAAAAAto/e3Dk5LFkfsAcim4Dw0qC9bpRg48wIDaXACLcB/s1600/IMG_4626.JPG", special_content: "did you know I am the coolest statue in melbourne", lock_type: "statue", name: "The library", status: "true")
  Visit.create!(user_id: user4.id, lock_id: lock.id, photo:"https://live.staticflickr.com/7581/15927731828_149cb4acee_b.jpg", unlocked_date: DateTime.new(2001,2,3,4,5,6,'+03:00'))
  Review.create!(rating: rand(5), comment: "best location ever!", user_id: user4.id)

  5.times do
    lock = Lock.create!(address: "#{rand(300)} #{street.sample}" , description: "a cool location that has many cool features", image: "https://4.bp.blogspot.com/-Vw_M7aTMY44/VzClQb44aCI/AAAAAAAAAto/e3Dk5LFkfsAcim4Dw0qC9bpRg48wIDaXACLcB/s1600/IMG_4626.JPG", special_content: "did you know I am the coolest statue in melbourne", lock_type: "statue", name: "The library", status: "true")
    Visit.create!(user_id: user4.id, lock_id: lock.id, photo:"https://live.staticflickr.com/7581/15927731828_149cb4acee_b.jpg", unlocked_date: DateTime.new(2001,2,3,4,5,6,'+03:00'))
    Review.create!(rating: rand(5), comment: "best location ever!", user_id: user4.id)
  end

  6.times do
    lock = Lock.create!(address: "#{rand(300)} #{street.sample}" , description: "a cool location that has many cool features", image: "https://4.bp.blogspot.com/-Vw_M7aTMY44/VzClQb44aCI/AAAAAAAAAto/e3Dk5LFkfsAcim4Dw0qC9bpRg48wIDaXACLcB/s1600/IMG_4626.JPG", special_content: "did you know I am the coolest statue in melbourne", lock_type: "statue", name: "The library", status: "true")
    Visit.create!(user_id: user5.id, lock_id: lock.id, photo:"https://live.staticflickr.com/7581/15927731828_149cb4acee_b.jpg", unlocked_date: DateTime.new(2001,2,3,4,5,6,'+03:00'))
    Review.create!(rating: rand(5), comment: "best location ever!", user_id: user5.id)
  end
