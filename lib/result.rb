class Result < ActiveRecord::Base
    belongs_to :action
    belongs_to :dev
end