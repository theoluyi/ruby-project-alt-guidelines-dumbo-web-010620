Action.destroy_all

a1 = Action.create(name: "freelance", payment: 50)
a2 = Action.create(name: "sell cauliflower", payment: 100)
a3 = Action.create(name: "go to gym", payment: -5)

puts "done seeding!"