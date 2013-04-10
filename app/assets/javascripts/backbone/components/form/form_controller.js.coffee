@PlanetExpress.module "Components.Form", (Form, App, Backbone, Marionette, $, _) ->
	
	class Form.Controller extends Marionette.Controller
		
		initialize: (view, options = {}) ->
			@formView = view
			
			@formLayout = @getFormLayout options
			
			@listenTo @formLayout, "show", @formContentRegion			
			@listenTo @formLayout, "close", @close
		
		onClose: ->
			delete @formLayout
			delete @formView
			delete @options			
			console.log "onClose", @
		
		formContentRegion: ->
			@formLayout.formContentRegion.show @formView
		
		getFormLayout: (options) ->
			config = @getDefaultOptions _.result(@formView, "form") 
			new Form.View
				config: config
		
		getDefaultOptions: (config = {}) ->
			console.log config
			
			_.defaults config,
				focusFirstInput: true
				footer: true
				buttons: @getButtonDefaults config.buttons
		
		getButtonDefaults: (buttons = {}) ->
			_.defaults buttons,
				primary: "Save"
				cancel: "Cancel"
				placement: "right"
					
	# API =
	# 	getFormWrapper: (view, options) ->
	# 		@formLayout = @getFormLayout view, options
	# 		
	# 		@formLayout.on "show", =>
	# 			@formContentRegion view
	# 		
	# 		@formLayout
	# 		
	# 	formContentRegion: (view) ->
	# 		@formLayout.formContentRegion.show view
		
		# getFormLayout: (view, options) ->
		# 	new Form.View
	
	App.reqres.setHandler "form:wrapper", (view, options = {}) ->
		## return view below here
		# API.getFormWrapper(view, options)
		formController = new Form.Controller(view, options)
		formController.formLayout
