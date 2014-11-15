# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file .env file.
LockUp.destroy_all
LockUp.create [
  {lat: 39.281195, lon: -76.6061881, name: "Dump" , description: "Got my Bike Stolen Here"},
  {lat: 39.279787, lon: -76.608441, name: "Fed Hill Park" , description: "Center of Federal Hill Park with a good pole to lock up to"},
  {lat: 39.278737, lon: -76.604069, name: "Awesome" , description: "Awesome bike rack to lockup to" },
  {lat: 39.277754, lon: -76.607081, name: "Safe" , description: "Federal Motors makes sure to hold your bike but only when there open ;)" },
  {lat: 39.276926, lon: -76.607874, name: "School Rack" , description: "A nice bike rack to chain to." },
  {lat: 39.274230, lon: -76.603293, name: "Lock and Eat" , description: "This Resturant lets you bring your bike inside and eat! =]"},
  {lat: 39.273500, lon: -76.602751, name: "Bike Shop" , description: "If you your bike here you get free bike keeping" },
  {lat: 39.273516, lon: -76.595874, name: "Suger Ride" , description: "Awesome bike lockup here, I love not having to walk to far to go to Domino Sugar" },
  {lat: 39.274626, lon: -76.591838, name: "Bmore Data Center", description: "Awesome bike rack" },
  {lat: 39.273010, lon: -76.592138, name: "Don't Lock Up Here", description: "Had my front wheel stolen! ughh!"}
]
