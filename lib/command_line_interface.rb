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

    def start_menu
        choice = select_prompt("", start_menu_options)
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

    def new_game
        greet
        character_creation
        story_setup
        hi_new_person
    end

    def load_game
        dev_menu_options = Dev.all.map(&:dev_name)
        choice = select_prompt("Pick a dev to play as!", dev_menu_options)
        case choice 
        when choice 
            self.dev = locate_dev_instance(choice)
        end
        puts "Welcome Back! now lets get the grind on!"
    end

    def story_setup  #(THEO)
        name = "#{self.dev.dev_name.capitalize}"
        puts "In the future, there is a broke software developer named #{self.dev.dev_name}..."
        sleep 1
        puts "#{self.dev.dev_name} has just graduated from a magically stressful job training program..."
        sleep 1
        puts "#{self.dev.dev_name} wants to be somebody, but has no job... no money... and absolutely no game..."
        sleep 1
        puts "In order to stop being such a loser and have a real life, #{self.dev.dev_name} will have to..."
        sleep 1
        puts "You need to Hustle hard..."
        sleep 1
        puts "chuck more wood than a woodchuck.."
        sleep 1
        puts "risk everything"
        sleep 1 
        puts "create a CLI app..possibly?"
        sleep 1
        puts "well.... anyway..."
        sleep 1
    end 


    def locate_dev_instance(name)
        Dev.find_by(dev_name: name)
    end
    
    def exit_game
        sleep 1.5
        puts "I didn't want to play with you anyway..."
        sleep 1
        puts "Butthead"
        sleep 1
        exit!
    end
    
    #---------------------------Char Creation-------------------------#
    def character_creation
        dev_name = naming_prompt("Hey... you, what's your name?")
        if Dev.find_by(dev_name: dev_name)
            notice("A Developer already got that name! \nPlease choose a different name... and be original PLEASE!", :red)
            return character_creation
        else
            self.dev = Dev.create(dev_name: dev_name, cash: 50)
            system("clear")
        end
    end

    def hi_new_person
        puts "Nice to meet you #{self.dev.dev_name}! 🤝"
        sleep 2
        puts "Oh hey.. you just found $#{self.dev.cash} on the floor!"
        puts "....."
        sleep 2
        puts "....."
        sleep 2
        puts "well....? nobody's looking, GO PICK IT UP!!"
        sleep 2
        puts "Congrats! now you have $#{self.dev.cash}. Started from the bottom, nothing changed....except this."
    end

    #--------------------Action Menu ---------------------------#
    def action_options
        ["Lets make some money Freelancing!",
        "I'm hungry, lets grab something to eat",
        "I HATE THIS! IM TURNING TO A LIFE OF CRIME MUAHAHA!!!!!",
        "I want to buy that new Macbook!"]
    end

    def freelance
        Result.create(action_id: Action.first.id, dev_id: self.dev.id, payment: rand(50..80))
    end

    def freelancing
        self.dev.cash += freelance.payment
        self.dev.save
    end

    def eat
        Result.create(action_id: Action.second.id, dev_id: self.dev.id, payment: rand(10..30))
    end

    def eat_food
        self.dev.cash -= eat.payment
        self.dev.save
    end

    def steal
        Result.create(action_id: Action.third.id, dev_id: self.dev.id, payment: rand(150000..350000))
    end

    def armed_robbery
        self.dev.cash += steal.payment
        self.dev.save
    end

    def mac
        Result.create(action_id: Action.last.id, dev_id: self.dev.id, payment: 1000)
    end

    def buy_mac
        self.dev.cash -= mac.payment
        self.dev.save
    end

    def action_menu
        choice = select_prompt("", action_options)
        case choice
        when "Lets make some money Freelancing!"
            freelancing
            puts "You made money!!!! good job!!! it wasn't the dream job...? but hey, beggars can't be choosers."
            sleep 2
            main_story
        when "I'm hungry, lets grab something to eat"
            eat_num = rand(1..5)
            if (self.dev.cash - eat.payment) < 0
                puts "Are you crazy?! you want to stay broke dont you?"
                sleep 1
                puts "You probably like to work for free, dont you?"
                sleep 3
                system("clear")
                main_story
            else
                if eat_num == 1
                    puts "You had some delicious food! it soothed your soul and gave you hope for pushing forward!"
                    eat_food
                    main_story
                elsif eat_num == 2
                    puts "You had some ramen... because.. ramen is nice."
                    eat_food
                    main_story
                elsif eat_num == 3
                    puts "you had a salad today! because health is good!!!"
                    eat_food
                    main_story
                elsif eat_num == 4
                    puts "Yogurt, gogurt, all the gurts. great food!!! Delicious probiotics!"
                    eat_food
                    main_story
                elsif eat_num == 5
                    puts "Eat some chinese food, because... ur craving MSG.. enough to kill an elephant"
                    eat_food
                    main_story
                end
            end

        when "I HATE THIS! IM TURNING TO A LIFE OF CRIME MUAHAHA!!!!!"
            puts "You turn to a life of crime!"
            crime_num = rand(1..10)
            sleep 1
                if crime_num <= 3
                    armed_robbery
                    crime_ending_good
                else
                    self.dev.destroy
                    crime_ending_bad
                end

        when "I want to buy that new Macbook!"
            if (self.dev.cash - mac.payment) < 0
                puts "I can't afford that yet!"
                sleep 1
                puts "time to get back on the grind!"
                sleep 3
                system("clear")
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
        if self.dev.cash > 20000
            puts "#{@dev.dev_name.capitalize}, this...RICH dev!!!"
            puts "$#{@dev.cash}"
            puts ""
        else
            puts "#{@dev.dev_name.capitalize}, this poor dev.."
            puts "$#{@dev.cash}"
            puts ""
        end
    end


    def crime_ending_good
        puts "..."
        puts "..."
        sleep 2
        puts ".....!!!!!"
        sleep 1
        puts "Holy crap, you pulled off the bank heist successfully!!"
        sleep 1
        puts "Well now that you're a multi-thousandaire... you got no money woes! congrats!"
        puts "This wasn't what I expected to happen to you... well Good job!"
        sleep 1
        puts "Anything with a big money win is a Win in my book. CONGRATS!"
        puts "Now maybe you can help some other poor devs!"
        exit!
    end

    def crime_ending_bad
        puts "sadly... You're BAD at this too! and.. one day, one of your heists went wrong!"
        sleep 1
        puts "You're stuck in a gunfight with the authorities! and their guns are better"
        puts "You're dead. The end."
        exit!
    end

    def game_ending
        puts "Congratulations! you bought a mac! now onto a brighter future!"
        puts "DUN DUN DUN! YOU WIN!!!!!!! .... or did you? wait this mac is another 2011?! DARNIT!"
        exit!
    end

    #------------------Title--------------------------#
    def opening_title
        title = TTY::Font.new(:doom)
        puts title.write("Broke Dev RPG")
        puts "
        
        `-:::-.`                                         
        -ohmmmmmmmdy+-                                      
     :ydmmmmmmmmmmmmmmh+`                                   
    :mmmmmmmmmmmmmmmmmmmh.                                  
    +mmmmmmmmmmmmmmmmmmmm-                                  
    .mmmmmmmmmmmmmdmmmds-                                   
    `:+syyhyyso+/:/:::`                                     
    `...-----..../h+..                                      
     ............---.`                                      
      ..............`                                       
        `........``                                         
         ...--.`                                            
        `//////:                    /.                      
        -///////`                   o/                      
        ////////:`                  +/                      
       ./////////-.```````          +/                      
       ://///////-....`  ...........s/                      
      `//////////:``  ```ooooooooooos-```                   
      .///////////    -/////////////////-                   
      :///////////.   .---//:-----//:---.                   
      -/ssssssssss+/::`   //-     :/:                       
       `hmmmmmmmmmmmmm`   //-     :/:                       
      `-:oooooo+::/mmh    //-     :/:                       
       .//////-`  .mmo    //-     :/:                       
        //////.   .mm-    //-     :/:                       
        //////.   .mm     //-     :/:                       
        //////.   .md/.`  //-     :/:                       
        ```````   `::::.  ```     ```                       "
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
        sleep 3
        system("clear")
        start_menu
        main_story
    end
end