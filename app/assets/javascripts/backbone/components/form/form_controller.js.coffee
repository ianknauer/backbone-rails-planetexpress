@PlanetExpress.module "Components.Form", (Form, App, Backbone, Marionette, $, _) ->
	
	class Form.Controller extends Marionette.Controller
		
		initialize: (view, options = {}) ->
			@contentView = view
			
			@formLayout = @getFormLayout options
						
			@listenTo @formLayout, "show", @formContentRegion			
			@listenTo @formLayout, "close", @close
			@listenTo @formLayout, "form:submit", @formSubmit
		
		formSubmit: ->
			data = Backbone.Syphon.serialize(@formLayout)

			if @contentView.onFormSubmit?(data) isnt false
				entities = _.pick @contentView, "model", "collection"

				@processFormSubmit data, entities
		
		processFormSubmit: (data, entities) ->
			model = entities.model
			collection = entities.collection
			throw "no model found inside of entities" unless model
			model.processUpdateOrCreate(data, collection) if model
		
		onClose: ->
			delete @formLayout
			delete @contentView
			delete @options			
			console.log "onClose", @
		
		formContentRegion: ->
			@formLayout.formContentRegion.show @contentView
		
		getFormLayout: (options) ->
			config = @getDefaultOptions _.result(@contentView, "form") 
			
			buttons = @getButtons config.buttons
			
			new Form.View
				config: config
				buttons: buttons
		
		getDefaultOptions: (config = {}) ->
			_.defaults config,
				focusFirstInput: true
				footer: true
		
		getButtons: (buttons = {}) ->
			App.request("form:button:entities", buttons, @contentView.model) unless buttons is false	
					
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
