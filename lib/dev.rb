class Dev < ActiveRecord::Base
    has_many :results
    has_many :actions, through: :results
end