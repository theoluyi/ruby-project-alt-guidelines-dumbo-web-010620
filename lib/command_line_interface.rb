class CommandLineInterface
    attr_accessor :dev, :action, :result, :devs, :actions, :results
    
    #-----------------Functions to re-use---------------------#
    def select_prompt(string, array_of_choices)
        prompt = TTY::Prompt.new
        prompt.select(string, array_of_choices)
    end
    
    def naming_prompt(string)
        prompt = TTY::Prompt.new
        name = prompt.ask(string, required: true)
        name.chomp
    end
    
    #---------------------------Char Creation-------------------------#
    def character_creation
        dev_name = naming_prompt("Hey... you, what's your name?")
        if Dev.find_by(dev_name: dev_name)
            notice("A Developer already got that name! \nPlease choose a different name... and be original PLEASE!", :red)
            return character_creation
        else
            @dev = Dev.create(dev_name: dev_name, cash: 50)
            system("clear")
        end
    end

    def hi_new_person
        puts "Nice to meet you #{@dev.dev_name}! 🤝"
        sleep 3
        puts "Oh hey.. you just found $#{@dev.cash} on the floor!"
        puts "....."
        sleep 2
        puts "....."
        sleep 2
        puts "well? nobody's looking, go pick it up!"
        sleep 2
        puts "Congrats! now you have $#{@dev.cash}. Started from the bottom, nothing changed....except this."
    end

    #--------------------Action Menu ---------------------------#
    def action_options
        ["Lets make some money Freelancing!",
        "I'm hungry, lets grab something to eat",
        "I want to buy that new Macbook!"]
    end

    def freelance
        Result.create(action_id: Action.first.id, dev_id: @dev.id, payment: rand(50..80))
    end

    def freelancing
        @dev.cash += freelance.payment
        @dev.save
    end

    def eat
        Result.create(action_id: Action.second.id, dev_id: @dev.id, payment: rand(10..30))
    end

    def eat_food
        @dev.cash -= eat.payment
        @dev.save
    end

    def mac
        Result.create(action_id: Action.last.id, dev_id: @dev.id, payment: 1000)
    end

    def buy_mac
        @dev.cash -= mac.payment
        @dev.save
    end

    def action_menu
        choice = select_prompt("", action_options)
        case choice
        when "Lets make some money Freelancing!"
            freelancing
            puts "You made money!!!! good job!!! it wasn't software engineering, but hey, beggars can't be choosers."
            main_story
        when "I'm hungry, lets grab something to eat"
            if (@dev.cash - eat.payment) < 0
                puts "Are you crazy?! you want to stay broke dont you?"
                puts "You probably like to work for free, dont you?"
                main_story
            else
                eat_food
                main_story
            end
        when "I want to buy that new Macbook!"
            if (@dev.cash - mac.payment) < 0
                puts "I can't afford that yet!"
                puts "time to get back on the grind!"
                main_story
            else
                buy_mac
                game_ending
            end
        end
    end

    #-----------------------Story-----------------------#
    def main_story
        status
        puts "lets do some shit"
        action_menu
    end


    def status
        puts "#{@dev.dev_name.capitalize}, this poor dev.."
        puts "$#{@dev.cash}"
        puts ""
    end

    def game_ending
        puts "Congratulations! you bought a mac! now onto a brighter future!"
        puts "DUN DUN DUN! YOU WIN!!!!!!!"
        exit!
    end

    #------------------Title--------------------------#
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


    #------------------------Intro----------------------------#
    def greet
        puts "Initializing new software developer..."
        sleep 2
        puts "pending....................."
        sleep 1
        puts "....................."
        sleep 1
        puts "....................."
        sleep 1
        puts "....................."
        sleep 3
        puts "Software Developer initialization complete"
        sleep 4
        puts "Wake up!!!" 
        sleep 2
    end

     #-------------------Story Board--------------------------------#
     def run 
        opening_title
        sleep 3.0
        system("clear")
        greet
        character_creation
        hi_new_person
        main_story
    end
end