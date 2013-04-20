@PlanetExpress.module "CrewApp.Edit", (Edit, App, Backbone, Marionette, $, _) ->
	
	Edit.Controller =
		
		edit: (id, crew) ->
			crew or= App.request "crew:entity", id
			
			# crew.on "all", (e) -> console.info e
			
			App.execute "when:fetched", crew, =>
				@layout = @getLayout crew
				
				@layout.on "show", =>
					@formRegion crew
				
				App.mainRegion.show @layout
		
		formRegion: (crew) ->
			editView = @getEditView crew
			formView = App.request "form:wrapper", editView
			
			@layout.formRegion.show formView
		
		getEditView: (crew) ->
			new Edit.Crew
				model: crew
		
		getLayout: (crew) ->
			new Edit.Layout
				model: crew