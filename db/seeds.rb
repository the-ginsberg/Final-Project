# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(name: "Tom Jones", email: "tomjones@example.com", phone_number: "954-234-2343", password: "password", password_confirmation: "password")

User.create(name: "Bob Thompson", email: "bobthompson@example.com", phone_number: "954-948-3743", password: "password", password_confirmation: "password")

User.create(name: "Amy Butler", email: "amybutler@example.com", phone_number: "954-293-3243", password: "password", password_confirmation: "password")
