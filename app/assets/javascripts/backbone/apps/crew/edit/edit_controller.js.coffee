@PlanetExpress.module "CrewApp.Edit", (Edit, App, Backbone, Marionette, $, _) ->
	
	class Edit.Controller extends App.Controllers.Base
		
		initialize: (id, crew) ->
			crew or= App.request "crew:entity", id
			
			@listenTo crew, "all", (e) -> console.info e
			
			@listenTo crew, "updated", ->
				App.vent.trigger "crew:updated", crew
			
			App.execute "when:fetched", crew, =>
				@layout = @getLayout crew
				
				@listenTo @layout, "show", =>
					@formRegion crew
				
				@show @layout
		
		formRegion: (crew) ->
			editView = @getEditView crew
			
			@listenTo editView, "form:cancel", ->
				App.vent.trigger "crew:cancelled", crew
			
			formView = App.request "form:wrapper", editView
			
			@layout.formRegion.show formView
		
		getEditView: (crew) ->
			new Edit.Crew
				model: crew
		
		getLayout: (crew) ->
			new Edit.Layout
				model: crew