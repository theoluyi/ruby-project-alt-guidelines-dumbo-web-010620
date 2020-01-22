class Action < ActiveRecord::Base
    has_many :results
    has_many :devs, through: :results
end