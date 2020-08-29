# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


  200.times do
    tweet = Tweet.create(content: Faker::Lorem.paragraph, user_id: 1, likes_count: 0, retweets_count: 0)
  end


