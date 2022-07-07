# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Lock.destroy_all
Visit.destroy_all
Review.destroy_all


user = User.create!(email: "beth@gmail.com", password: "password" )
user2 = User.create!(email: "moo@gmail.com", password: "password" )
street = ["Flinders St VIC 3000", "Collins St VIC 3000", "La Trobe Street VIC 3000", "Lonsdale St VIC 3000"]

4.times do
  lock = Lock.create!(address: "#{rand(300)} #{street.sample}" , description: "a cool location that has many cool features", image: "https://4.bp.blogspot.com/-Vw_M7aTMY44/VzClQb44aCI/AAAAAAAAAto/e3Dk5LFkfsAcim4Dw0qC9bpRg48wIDaXACLcB/s1600/IMG_4626.JPG", special_content: "did you know I am the coolest statue in melbourne", lock_type: "statue", name: "Larry La Trobe", status: "true")
  Visit.create!(user_id: user.id, lock_id: lock.id, photo:"https://live.staticflickr.com/7581/15927731828_149cb4acee_b.jpg", unlocked_date: DateTime.new(2001,2,3,4,5,6,'+03:00'))
  Review.create!(rating: rand(5), comment: "best location ever!", user_id: user.id)
end
