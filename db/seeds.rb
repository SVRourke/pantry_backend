# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(name: 'Sam', email: 'Sam@gmail.com', password: 'password')
User.create(name: 'Sharain', email: 'Sharain@gmail.com', password: 'password')
User.create(name: 'Maya', email: 'Maya@gmail.com', password: 'password')

User.create(name: 'Rohan', email: 'Rohan@gmail.com', password: 'password')
User.create(name: 'Jake', email: 'Jake@gmail.com', password: 'password')
User.create(name: 'Autumn', email: 'Autumn@gmail.com', password: 'password')

User.all[0].friends.push(User.all[1])
User.all[0].friends.push(User.all[2])
User.all[0].friends.push(User.all[3])
User.all[0].friends.push(User.all[4])
User.all[0].friends.push(User.all[5])

User.all[1].friends.push(User.all[2])
User.all[1].friends.push(User.all[3])
User.all[1].friends.push(User.all[5])

User.all[1].pending_friends.push(User.all[4])
User.all[5].pending_friends.push(User.all[4])


first = List.create(name: "Sam's List")
second = List.create(name: "Rain & Sam's List")
third = List.create(name: "Squad")

User.all.each do |user|
    if user.name != 'Jake' 
        third.contributors.push(user)
    end
end

second.contributors.push(User.first)
second.contributors.push(User.all[1])

first.contributors.push(User.first)
first.list_invites.create(requestor: User.first, pending_contributor: User.find_by(name: 'Jake'))
