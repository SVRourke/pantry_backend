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

User.first.friends.push(User.all[1])
User.first.friends.push(User.all[2])
User.first.friends.push(User.all[3])
User.first.friends.push(User.all[4])

User.all[1].friends.push(User.all[2])
User.all[1].friends.push(User.all[3])
User.all[1].friends.push(User.all[5])

User.all[1].pending_friends.push(User.all[4])
User.all[5].pending_friends.push(User.all[4])


first = List.create(name: "Sam's List")
second = List.create(name: "Rain & Sam's List")
third = List.create(name: "Squad")


User.all.each do |user|
    if !['Jake', 'Sam'].include? user.name 
        third.contributors.push(user)
    end
end

second.contributors.push(User.first)
second.contributors.push(User.all[1])

first.contributors.push(User.first)
third.list_invites.create(requestor: User.first, pending_contributor: User.find_by(name: 'Jake'))
third.list_invites.create(requestor: User.all[1], pending_contributor: User.first)

second.items.create([
    {
        user: User.first,
        name: "Dried Mangoes",
        amount: "1 bag",
    },
    {
        user: User.first,
        name: "Farfalle",
        amount: "one box",
    },
    {
        user: User.all[1],
        name: "Chobanis",
        amount: "2 each strawberry, mixed berries",
    },
    {
        user: User.all[1],
        name: "Keilbasa",
        amount: "1 package",
    }
])

first.items.create(
    user: User.first,
    name: "pencils",
    amount: "one box"
)