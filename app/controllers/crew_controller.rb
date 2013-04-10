class CrewController < ApplicationController
	respond_to :json
	
	def index
		@crew = Crew.all
	end
	
	def show
		sleep 5
		@member = Crew.find params[:id]
	end
end