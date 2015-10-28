# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#User.create email: "e1@gmail.com", name: "e1", password: "12345678", password_confirmation: "12345678"
#User.create email: "e2@gmail.com", name: "e1", password: "12345678", password_confirmation: "12345678"
u = User.create email: "example@gmail.com", name: "for-test", password: "12345678", password_confirmation: "12345678"

20.times do |i|
  g = Group.create title: "title-#{i}", description: "desc-#{i}", user_id: u.id
  g.members << u
  
  30.times do |n|
    Post.create content: "post-content-grp#{i}-post#{n}", group_id: g.id, user_id: u.id
  end
end