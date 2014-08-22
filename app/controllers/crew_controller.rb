class CrewController < ApplicationController
  respond_to :json

  def index
    @crew = Crew.all
  end

  def show
    @member = Crew.find params[:id]
  end
end
