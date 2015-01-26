# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# User.create!(
#     name: 'Winter Cohort',
#     email: 'winter2015@devpointlabs.com',
#     password: 'password',
#     password_confirmation: 'password'
#   )

CSV.foreach("db/projects.csv", headers: true) do |row|
  User.create!(
    name: row['name'],
    email: row['email'],
    password: row['password'],
    password_confirmation: row['password_confirmation']
    )
end