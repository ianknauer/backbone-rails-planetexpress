@PlanetExpress.module "CrewApp.New", (New, App, Backbone, Marionette, $, _) ->
	
	class New.Controller extends App.Controllers.Base
		
		initialize: ->
			console.log @region
			crew = App.request "new:crew:entity"
			
			@listenTo crew, "all", (e) -> console.info e
			
			@listenTo crew, "created", ->
				App.vent.trigger "crew:created", crew
			
			newView = @getNewView crew
			formView = App.request "form:wrapper", newView
			
			@listenTo newView, "form:cancel", =>
				@region.close()

			@show formView
				
		getNewView: (crew) ->
			new New.Crew
				model: crew