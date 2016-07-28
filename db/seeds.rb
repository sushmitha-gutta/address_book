# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Contact.create!([
	{id: 1, name: "Nin", zipcode: 345023},
     {id: 2, name: "Lucy", zipcode: 367023},
     {id: 3, name: "Kathy", zipcode: 445025},
     {id: 4, name: "Peter", zipcode: 675023},

	])