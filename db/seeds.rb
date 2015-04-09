# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Event.create!(short_name:"gouveole", 
    name:"Gouveole",
    description:"Gouveole",
    open: DateTime.new(2014,07,14),
    close: DateTime.new(2014,10,01),
    visible: true)

Event.create!(short_name:"nursing15", 
    name:"Nursing2015",
    description:"Nursing 2015",
    open: DateTime.new(2014,07,14),
    close: DateTime.new(2016,10,01),
    visible: true)