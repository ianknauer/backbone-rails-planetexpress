@PlanetExpress.module "Components.Form", (Form, App, Backbone, Marionette, $, _) ->
	
	API =
		getFormWrapper: (view, options) ->
			@formLayout = @getFormLayout view, options
			
			@formLayout.on "show", =>
				@formContentRegion view
			
			@formLayout
			
		formContentRegion: (view) ->
			@formLayout.formContentRegion.show view
		
		getFormLayout: (view, options) ->
			new Form.View
	
	App.reqres.setHandler "form:wrapper", (view, options = {}) ->
		## return view below here
		API.getFormWrapper(view, options)
