class Crew < ActiveRecord::Base
  attr_accessible :age, :avatar, :name, :origin, :quote, :species, :title

	validates_presence_of :name, :title, :origin
end
