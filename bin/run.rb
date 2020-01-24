require_relative '../config/environment'
ActiveRecord::Base.logger.level = 1 # Disables logging

cli = CommandLineInterface.new
cli.rrun 
