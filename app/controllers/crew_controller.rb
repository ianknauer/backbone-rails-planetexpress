class CrewController < ApplicationController
	respond_to :json
	
	def index
		@crew = Crew.all
	end
end