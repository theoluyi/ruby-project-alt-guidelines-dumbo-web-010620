class Result < ActiveRecord::Base
    belongs_to :action
    belongs_to :dev 

    # :cash_payout = Action.cash * random_multiplier

end