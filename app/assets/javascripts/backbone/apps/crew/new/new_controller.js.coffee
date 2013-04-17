@PlanetExpress.module "CrewApp.New", (New, App, Backbone, Marionette, $, _) ->
	
	New.Controller =
		
		newCrew: ->
			crew = App.request "new:crew:entity"
			
			crew.on "all", (e) -> console.info e
			
			crew.on "created", ->
				App.vent.trigger "crew:created", crew
			
			newView = @getNewView crew
			
			App.request "form:wrapper", newView
				
		getNewView: (crew) ->
			new New.Crew
				model: crew