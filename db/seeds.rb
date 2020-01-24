#Destroying all previous DB.
Action.destroy_all
Dev.destroy_all
Result.destroy_all

freelance = Action.create(action_name: "Freelance")
eat_food = Action.create(action_name: "Eat food")
buy_a_mac = Action.create(action_name: "Buy a Macbook Pro")

##testing Github ##
puts "done seeding!"