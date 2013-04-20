class CrewController < ApplicationController
	respond_to :json
	
	def index
		# sleep 5
		@crew = Crew.all
	end
	
	def show
		# sleep 5
		@member = Crew.find params[:id]
	end
	
	def update
		sleep 1
		@member = Crew.find(params[:id])
		if @member.update_attributes(params)
			render "crew/show"
		else
			respond_with @member
		end
	end
	
	def create
		sleep 1
		@member = Crew.new
		if @member.update_attributes(params)
			render "crew/show"
		else
			respond_with @member
		end
	end
end