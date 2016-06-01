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

Event.create!(short_name:"psy16", 
    name:"Le Soin intensif en psychiatrie",
    description:"Le Soin intensif en psychiatrie",
    open: DateTime.new(2014,07,14),
    close: DateTime.new(2016,10,10),
    visible: true)

Event.create!(short_name:"js16",
    name:"Journée scientifique 2016",
    description:"Vieillir en institution, vieillesses institutionnalisées. Nouvelles populations, nouveaux lieux, nouvelles pratiques",
    open: DateTime.new(2014,07,14),
    close: DateTime.new(2016,11,01),
    visible: true)