class CommandLineInterface
    attr_accessor :dev, :action, :result

    def run 
        greet
        whats_your_name
    end 

    def greet
        puts "Initializing new software developer... "
        sleep 1.5
        puts "Wake up!!!"  
    end

    def whats_your_name
        prompt = TTY::Prompt.new
        dev_name = prompt.ask("Hey new guy, what's your name?")
        puts "Nice to meet you #{dev_name}! 🤝"
        Dev.create(name: dev_name, cash: 100)
    end 



end 

