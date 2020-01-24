class CommandLineInterface
    attr_accessor :dev, :action, :result

    def rrun
        opening_title
        sleep 2.0
        start_menu # done
        # greet
        # story
        #x_action_menu  

        #NOTE TO SELF: I don't think I want all this inside #rrun but for now it's okay, it's a flowchart
    end 

    # Reusable TTY Prompts 
    def select_prompt(string, array_of_choices) 
        prompt = TTY::Prompt.new 
        prompt.select(string, array_of_choices) 
    end

    # First/opening menu options
    def start_menu
        choice = select_prompt("", start_menu_options)
        #choice = choice.parameterize.underscore converts choice to snake_case
        case choice
        when "New Game"
            new_game
        when "Load Game"
            load_game
        when "Exit"
            exit_game
        end
    end 

    # Menu options
    def start_menu_options
        ["New Game", "Load Game", "Exit"]
    end

    def whats_your_name
        prompt = TTY::Prompt.new
        dev_name = prompt.ask("Hey new guy, what's your name?")
        puts "Nice to meet you #{dev_name}!"
        self.dev = Dev.create(name: dev_name, cash: 100)
    end

    def new_game
        whats_your_name
        story_setup
        #x_action_menu 
    end

    def load_game
        dev_menu_options = Dev.all.map(&:name)
        choice = select_prompt("Pick a dev to play as!", dev_menu_options)
        case choice 
        when choice 
            self.dev = locate_dev_instance(choice)
        end
        story_setup
    end

    # def set_player_as()
    #     choice = select_prompt("Pick a dev to play as!", dev_menu_options)
    #     CommandLineInterface.dev = locate_dev_instance(choice)
    # end

    def story_setup  #(THEO)
        name = "#{self.dev.name.capitalize}"
        puts "In the future, there is a broke software developer named #{name}..."
        sleep 1.5
        puts "#{name}'s just graduated from a magically stressful job training program..."
        sleep 1.5
        puts "#{name} wants to be somebody, but has no job, no money, and absolutely no game..."
        sleep 1.5
        puts "In order to stop being such a loser and have a real life, #{name} will have to..."
        sleep 1.5
        puts "Hustle hard, chuck more wood than a woodchuck, risk everything, create a CLI app, make connections, all of the above, pick C because #{name} doesn't understand the question."
        sleep 1.5

        # ___Goes to study programming on Udemy 
        # Feeling hungry and broke
        # You got out of lecture and have two hours to kill. What do you want to do?
    end 


    def locate_dev_instance(name)
        Dev.find_by(name: name)
    end

    def delete_dev(name)
    end 
    

    def exit_game
        sleep 1.5
        puts "I didn't want to play with you anyway..."
        sleep 1
        puts "Butthead"
        sleep 1
    end 

    def greet
        puts "Initializing new software developer... "
        sleep 1.0
        puts "......................................"
        sleep 1.0
        puts "Wake up #{self.dev.name}!!!"
    end 

    def opening_title
        title = TTY::Font.new(:doom)
        puts title.write("Broke Dev RPG")
        puts "
        XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
        X///::::::::::::::................................................................::::::://////////X
        X///:::::::::::::..................................................................:::::://////////X
        X////::::::::::....................................................................:::::://////////X
        X////::::::::::..................................................................::::::::://///////X
        X////::::::::...................................................................:::::::::://///////X
        X////::::::::....................................................................::::::::::////////X
        X////:::::::::......................................................................::::::::///////X
        X///:::::::::.....................................................................::::::::::://////X
        X///::::::::::............................o++/-..--..--..```` ....................::::::::::://////X
        X//:::::/:::::......................`````oddhhhhhhhyo///:-.`  `......................:::::::://////X
        X///::::y/................/+++/:-......-:/hmddddhysssossssoo+/:-..--.```...............-::::://////X
        X//:::::/y............/syyyyyo++ooo++///o+dNNNmddmdyssssyyyhhyyo++/:-```..................::://////X
        X//::::::/y.......:++ydyyyyso/://///::::+odMMMmmmmmhddhhmyyhhdhysyhdho:.................::::///////X
        X//......./y......dMNmhhhhyso+///:----:/oshMMMNmmmNNmhdNdhdyyyhdhdmmmmhy+.........:-::::::::///////X
        X///.......+s..../mMNmhhdysso+++/:--/+osssyMMMMNNNNmmdNddmhoosyhmmhmmmmmdy+......::::::::::////////X
        X///........+s....dMMNNmdysoo+ys:+so+ossyhmMMMMMMNNNmNmNmmhssssdmmhddmmmmmdy:..::::::::::://///////X
        X////........oo...yNMNNNdhyso++++/++oyyyydNMMMMMMMNNNNNNNmdhsoydmdhhhhdmmmmdh/-:::::://////////////X
        X////.........o+..sMMMNNmdhso++++++ossyhhdmMMMMMMMNNNNNNNmmdhhhyhNdhhhhddmmmdds:::::/yhhyyssoo+++++X
        X///////.......s+..hMMMNdyhdhso+++sossyhdmNNMMMMMMNNNNNNNNNmmdmhhmdhhdhhhhhmhmmh+:::ohddddhhyysooooX
        X/////////......yos/mMMMmmmhsssyshNNNNNNds/+NMMMMMMNNNNNNNNNmNddNmhhsddhhyhdddmmms:+hddddhhhyyssssdX
        X:::::::::::----:yhsoNMMMNmmddNNNhdNMNo/::-.-sNMMMMMNNNNNNNNNNdNmdmhoymmddddmdmmmmhyhddhhhhyyyyysdMX
        X:::::::::::::::/ohhyydddhhhhhhddddmmmso////os+yMMMMMMMMMNMMNNMmdmmdysdmmmddddddmmmmhhhhhyyyyyyydMNX
        X.....------:::/+oyhhhddddddhdddhddmdddhddddddddmmNMMMMMMMMNMMNmNmddhyydmdddhhddddmmmhhhyyyyyyyhMNNX
        XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n\n\n\n\n"
    end

    # binding.pry 
    # puts "you're a real sexy dev!"
    # not sure why I can't get methods to run while I'm in this pry
end 

# not sure if I have all my ends.
# exit_message is 



# # ----------------------------------------------------------------------------

# # COMMAND LINE INTERFACE

#     # --------------------------
#     def x_title_screen #(LUKE)
#         # TTY Title-name
#         # ASCII Art - Dev Dork
#         # Sleep 1.5-3
#     end 

#     # --------------------------
#     def opening_menu  #(THEO) # see start_game_menu above
#         # TTY prompt
#         # New game
#         # "Hey you, what's your name?"
#         # Input = Dev.Create(gets.chomp)
#         # Hey (self.dev), you found $50.
#         # Exit game - exit out of game.
#     end 

#     # --------------------------
#     def action_menu #(LUKE)
#         # this has all the actions that the user can do in here
#     end 



#     def update_dev_stats #(THEO)
#     # delayed variable reward:
#     # Puts "Dev is freelancing for face magazine…"
#     # Sleep 1.5
#     # Puts "dev got #{Result#cash_earned}
#     end 


#     # -------------------------
#     def read_dev #(THEO)
#     # determines next step based on dev.savings
#     # puts some kind of feedback to screen
#     end 





