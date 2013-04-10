class CrewController < ApplicationController
	respond_to :json
	
	def index
		# sleep 5
		@crew = Crew.all
	end
	
	def show
		sleep 5
		@member = Crew.find params[:id]
	end
end