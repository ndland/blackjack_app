# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Table.new(name: "Beginner's Table", min: 10, max: 50).save
Table.new(name: "Intermediate Table", min: 50, max: 100).save
Table.new(name: "High Roller Table", min: 100).save
