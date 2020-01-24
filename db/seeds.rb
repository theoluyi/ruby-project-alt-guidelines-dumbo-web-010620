#Destroying all previous DB.
Action.destroy_all
Dev.destroy_all
Result.destroy_all

Action.create(action_name: "Freelance")
Action.create(action_name: "Eat food")
Action.create(action_name: "Armed Robbery")
Action.create(action_name: "Buy a Macbook Pro")

##testing Github ##
puts "done seeding!"